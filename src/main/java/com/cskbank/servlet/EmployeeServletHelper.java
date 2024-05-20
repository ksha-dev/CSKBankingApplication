package com.cskbank.servlet;

import java.io.IOException;
import java.util.Objects;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cskbank.exceptions.AppException;
import com.cskbank.filters.Parameters;
import com.cskbank.modules.Account;
import com.cskbank.modules.Account.AccountType;
import com.cskbank.modules.AuditLog;
import com.cskbank.modules.CustomerRecord;
import com.cskbank.modules.EmployeeRecord;
import com.cskbank.modules.Transaction;
import com.cskbank.modules.UserRecord;
import com.cskbank.modules.UserRecord.Type;
import com.cskbank.utility.ConvertorUtil;
import com.cskbank.utility.ServletUtil;
import com.cskbank.utility.ConstantsUtil.LogOperation;
import com.cskbank.utility.ConstantsUtil.OperationStatus;
import com.cskbank.utility.ConstantsUtil.TransactionType;

class EmployeeServletHelper {

	public void accountDetailsGetRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, AppException {
		Long accountNumber = ConvertorUtil
				.convertStringToLong(request.getParameter(Parameters.ACCOUNTNUMBER.parameterName()));
		Account account = Services.employeeOperations.getAccountDetails(accountNumber);
		CustomerRecord customer = Services.employeeOperations.getCustomerRecord(account.getUserId());
		request.setAttribute("account", account);
		request.setAttribute("customer", customer);
		request.getRequestDispatcher("/WEB-INF/jsp/employee/account_details.jsp").forward(request, response);
	}

	public void statementGetRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, AppException {
		String accountNumber = request.getParameter(Parameters.ACCOUNTNUMBER.parameterName());
		if (!Objects.isNull(accountNumber)) {
			request.setAttribute("accountNumber", ConvertorUtil.convertStringToLong(accountNumber));
		}
		request.getRequestDispatcher("/WEB-INF/jsp/common/statement_select.jsp").forward(request, response);
	}

	public void branchAccountsRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {
		EmployeeRecord employee = (EmployeeRecord) ServletUtil.getUser(request);
		int pageCount = 0;
		int currentPage = 1;
		if (request.getMethod().equals("POST")) {
			currentPage = ConvertorUtil
					.convertStringToInteger(request.getParameter(Parameters.CURRENTPAGE.parameterName()));
			pageCount = ConvertorUtil
					.convertStringToInteger(request.getParameter(Parameters.PAGECOUNT.parameterName()));
		}

		if (pageCount <= 0) {
			pageCount = Services.employeeOperations.getBranchAccountsPageCount(employee.getUserId());
		}
		request.setAttribute("accounts",
				Services.employeeOperations.getListOfAccountsInBranch(employee.getUserId(), currentPage));
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("branch", Services.employeeOperations.getBrachDetails(employee.getBranchId()));
		request.getRequestDispatcher("/WEB-INF/jsp/employee/branch_accounts.jsp").forward(request, response);
	}

	public void searchPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {
		EmployeeRecord employee = (EmployeeRecord) ServletUtil.getUser(request);
		String searchBy = request.getParameter(Parameters.SEARCHBY.parameterName());
		String searchValue = request.getParameter(Parameters.SEARCHVALUE.parameterName());
		try {
			if (searchBy.equals("customerId")) {
				int userId = ConvertorUtil.convertStringToInteger(searchValue);
				request.setAttribute("customer",
						(CustomerRecord) Services.employeeOperations.getCustomerRecord(userId));
				request.setAttribute("accounts", Services.employeeOperations.getAssociatedAccountsOfCustomer(userId));
				request.getRequestDispatcher("/WEB-INF/jsp/employee/search_customer.jsp").forward(request, response);

				// Log
				AuditLog log = new AuditLog();
				log.setUserId(employee.getUserId());
				log.setTargetId(userId);
				log.setLogOperation(LogOperation.VIEW_CUSTOMER);
				log.setOperationStatus(OperationStatus.SUCCESS);
				log.setDescription("Customer details (ID : " + userId + ") was searched and viewed by "
						+ employee.getType() + " (ID :  " + employee.getUserId() + ")");
				log.setModifiedAtWithCurrentTime();
				Services.auditLogService.log(log);

			} else if (searchBy.equals("accountNumber")) {
				long accountNumber = ConvertorUtil.convertStringToLong(searchValue);
				Account account = Services.employeeOperations.getAccountDetails(accountNumber);
				CustomerRecord customer = Services.employeeOperations.getCustomerRecord(account.getUserId());
				request.setAttribute("account", account);
				request.setAttribute("customer", customer);
				request.getRequestDispatcher("/WEB-INF/jsp/employee/search_account.jsp").forward(request, response);

				// Log
				AuditLog log = new AuditLog();
				log.setUserId(employee.getUserId());
				log.setLogOperation(LogOperation.VIEW_ACCOUNT);
				log.setOperationStatus(OperationStatus.SUCCESS);
				log.setDescription("Account details (ID : " + accountNumber + ") was searched and viewed by "
						+ employee.getType() + " (ID :  " + employee.getUserId() + ")");
				log.setModifiedAtWithCurrentTime();
				Services.auditLogService.log(log);

			} else {
				throw new AppException("Invalid Search By Field Obtained");
			}
		} catch (AppException e) {
			ServletUtil.session(request).setAttribute("error", e.getMessage());
			response.sendRedirect("search");
		}
	}

	public void authorizeTransactionPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {
		try {
			long accountNumber = ConvertorUtil
					.convertStringToLong(request.getParameter(Parameters.ACCOUNTNUMBER.parameterName()));
			double amount = ConvertorUtil
					.convertStringToDouble(request.getParameter(Parameters.AMOUNT.parameterName()));
			TransactionType type = TransactionType
					.convertStringToEnum(request.getParameter(Parameters.TYPE.parameterName()));

			Services.employeeOperations.getAccountDetails(accountNumber);
			ServletUtil.session(request).setAttribute("accountNumber", accountNumber);
			ServletUtil.session(request).setAttribute("amount", amount);
			ServletUtil.session(request).setAttribute("type", type);
			request.getRequestDispatcher("/WEB-INF/jsp/common/authorization.jsp?redirect=process_transaction")
					.forward(request, response);
		} catch (AppException e) {
			ServletUtil.session(request).setAttribute("error", e.getMessage());
			response.sendRedirect("transaction");
		}
	}

	public void processTransactionPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {
		EmployeeRecord employee = (EmployeeRecord) ServletUtil.getUser(request);
		String pin = request.getParameter(Parameters.PIN.parameterName());
		long accountNumber = (long) ServletUtil.session(request).getAttribute("accountNumber");
		double amount = (double) ServletUtil.session(request).getAttribute("amount");
		TransactionType type = (TransactionType) ServletUtil.session(request).getAttribute("type");
		try {
			Transaction transaction;
			if (type == TransactionType.CREDIT) {
				transaction = Services.employeeOperations.depositAmount(employee.getUserId(), accountNumber, amount,
						pin);
			} else {
				transaction = Services.employeeOperations.withdrawAmount(employee.getUserId(), accountNumber, amount,
						pin);
			}
			request.setAttribute("status", true);
			request.setAttribute("message",
					"Your Transaction has been completed!<br>Tranaction ID : " + transaction.getTransactionId());
			request.setAttribute("redirect", "branch_accounts");

			// Log
			AuditLog log = new AuditLog();
			log.setUserId(employee.getUserId());
			log.setTargetId(transaction.getUserId());
			log.setLogOperation(LogOperation.EMPLOYEE_TRANSACTION);
			log.setOperationStatus(OperationStatus.SUCCESS);
			log.setDescription(employee.getType() + " (ID : " + employee.getUserId() + ") has "
					+ (transaction.getTransactionType() == TransactionType.CREDIT ? "deposited " : "withdrawn ")
					+ ConvertorUtil.amountToCurrencyFormat(transaction.getTransactedAmount())
					+ " from Account(Acc/No : " + accountNumber + ")");
			log.setModifiedAt(transaction.getCreatedAt());
			Services.auditLogService.log(log);

		} catch (AppException e) {
			request.setAttribute("status", false);
			request.setAttribute("message", e.getMessage());
			request.setAttribute("redirect", "transaction");

			// Log
			AuditLog log = new AuditLog();
			Account account = Services.employeeOperations.getAccountDetails(accountNumber);
			log.setUserId(employee.getUserId());
			log.setTargetId(account.getUserId());
			log.setLogOperation(LogOperation.EMPLOYEE_TRANSACTION);
			log.setOperationStatus(OperationStatus.FAILURE);
			log.setDescription(employee.getType() + "(ID : " + employee.getUserId() + ") "
					+ (type == TransactionType.CREDIT ? "deposit" : "withdrawal") + "failed on Account(Acc/No : "
					+ accountNumber + ") - " + e.getMessage());
			log.setModifiedAtWithCurrentTime();
			Services.auditLogService.log(log);

		}
		request.getRequestDispatcher("/WEB-INF/jsp/common/transaction_status.jsp").forward(request, response);
	}

	public void authorizeOpenAccount(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {
		Account.AccountType accountType = Account.AccountType
				.convertStringToEnum(request.getParameter(Parameters.TYPE.parameterName()));
		double amount = ConvertorUtil.convertStringToDouble(request.getParameter(Parameters.AMOUNT.parameterName()));
		String customerType = request.getParameter(Parameters.CUSTOMERTYPE.parameterName());
		try {
			if (customerType.equals("new")) {
				CustomerRecord newCustomer = new CustomerRecord();

				newCustomer.setFirstName(request.getParameter(Parameters.FIRSTNAME.parameterName()));
				newCustomer.setLastName(request.getParameter(Parameters.LASTNAME.parameterName()));
				newCustomer.setDateOfBirth(
						ConvertorUtil.dateStringToMillis(request.getParameter(Parameters.DATEOFBIRTH.parameterName())));
				newCustomer.setGender(
						ConvertorUtil.convertStringToInteger(request.getParameter(Parameters.GENDER.parameterName())));
				newCustomer.setAddress(request.getParameter(Parameters.ADDRESS.parameterName()));
				newCustomer.setPhone(
						ConvertorUtil.convertStringToLong(request.getParameter(Parameters.PHONE.parameterName())));
				newCustomer.setEmail(request.getParameter(Parameters.EMAIL.parameterName()));
				newCustomer.setAadhaarNumber(
						ConvertorUtil.convertStringToLong(request.getParameter(Parameters.AADHAAR.parameterName())));
				newCustomer.setPanNumber(request.getParameter(Parameters.PAN.parameterName()));

				ServletUtil.session(request).setAttribute("newCustomer", newCustomer);
			} else if (customerType.equals("existing")) {
				int customerId = ConvertorUtil
						.convertStringToInteger(request.getParameter(Parameters.USERID.parameterName()));
				Services.employeeOperations.getCustomerRecord(customerId);
				ServletUtil.session(request).setAttribute("customerId", customerId);
			}
			ServletUtil.session(request).setAttribute("accountType", accountType);
			ServletUtil.session(request).setAttribute("amount", amount);
			ServletUtil.session(request).setAttribute("customerType", customerType);
			request.getRequestDispatcher("/WEB-INF/jsp/common/authorization.jsp?redirect=process_open_account")
					.forward(request, response);
		} catch (AppException e) {
			ServletUtil.session(request).setAttribute("error", e.getMessage());
			response.sendRedirect("open_account");
		}
	}

	public void processOpenAccountPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {
		EmployeeRecord employee = (EmployeeRecord) ServletUtil.getUser(request);
		String pin = request.getParameter(Parameters.PIN.parameterName());
		Account.AccountType accountType = (Account.AccountType) ServletUtil.session(request).getAttribute("accountType");
		double amount = (double) ServletUtil.session(request).getAttribute("amount");
		String customerType = (String) ServletUtil.session(request).getAttribute("customerType");
		Account newAccount = null;
		try {
			if (customerType.equals("new")) {
				CustomerRecord newCustomer = (CustomerRecord) ServletUtil.session(request).getAttribute("newCustomer");
				newAccount = Services.employeeOperations.createNewCustomerAndAccount(newCustomer, accountType, amount,
						employee.getUserId(), pin);
				request.setAttribute("message", "New customer and account has been created\nCustomer ID : "
						+ newCustomer.getUserId() + "\nAccount Number : " + newAccount.getAccountNumber());

				// Log
				AuditLog log = new AuditLog();
				log.setUserId(employee.getUserId());
				log.setTargetId(newCustomer.getUserId());
				log.setLogOperation(LogOperation.CREATE_CUSTOMER);
				log.setOperationStatus(OperationStatus.SUCCESS);
				log.setDescription("Customer(ID : " + newCustomer.getUserId() + ") was created by " + employee.getType()
						+ "(ID : " + employee.getUserId() + ")");
				log.setModifiedAt(newCustomer.getCreatedAt());
				Services.auditLogService.log(log);

			} else if (customerType.equals("existing")) {
				int customerId = (int) ServletUtil.session(request).getAttribute("customerId");
				newAccount = Services.employeeOperations.createAccountForExistingCustomer(customerId, accountType,
						amount, employee.getUserId(), pin);
				request.setAttribute("message",
						"New account has been created\nAccount Number : " + newAccount.getAccountNumber());
			}

			request.setAttribute("status", true);
			request.setAttribute("redirect", "branch_accounts");

			// Log
			AuditLog log = new AuditLog();
			log.setUserId(employee.getUserId());
			log.setTargetId(newAccount.getUserId());
			log.setLogOperation(LogOperation.CREATE_ACCOUNT);
			log.setOperationStatus(OperationStatus.SUCCESS);
			log.setDescription("Account(Acc/No : " + newAccount.getAccountNumber() + ") was created by "
					+ employee.getType() + "(ID : " + employee.getUserId() + ")");
			log.setModifiedAt(newAccount.getCreatedAt());
			Services.auditLogService.log(log);

		} catch (AppException e) {
			request.setAttribute("status", false);
			request.setAttribute("redirect", "open_account");
			request.setAttribute("message", e.getMessage());

			// Log
			AuditLog log = new AuditLog();
			log.setUserId(employee.getUserId());
			log.setLogOperation(LogOperation.CREATE_CUSTOMER_AND_ACCOUNT);
			log.setOperationStatus(OperationStatus.FAILURE);
			log.setDescription("Create customer and open account failed " + employee.getType() + "(ID : "
					+ employee.getUserId() + ") - " + e.getMessage());
			log.setModifiedAtWithCurrentTime();
			Services.auditLogService.log(log);

		}
		request.getRequestDispatcher("/WEB-INF/jsp/common/transaction_status.jsp").forward(request, response);
	}

	public void authorizeCloseAccountPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {
		EmployeeRecord employee = (EmployeeRecord) ServletUtil.getUser(request);
		long accountNumber = ConvertorUtil
				.convertStringToLong(request.getParameter(Parameters.ACCOUNTNUMBER.parameterName()));
		try {
			Services.employeeOperations.getAccountDetails(accountNumber);
			ServletUtil.session(request).setAttribute("accountNumber", accountNumber);
			request.getRequestDispatcher("/WEB-INF/jsp/common/authorization.jsp?redirect=process_close_account")
					.forward(request, response);
		} catch (AppException e) {
			ServletUtil.session(request).setAttribute("error", e.getMessage());
			response.sendRedirect(employee.getType() == UserRecord.Type.ADMIN ? "accounts" : "branch_accounts");
		}
	}

	public void processCloseAccountPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {
		EmployeeRecord employee = (EmployeeRecord) ServletUtil.getUser(request);
		String pin = request.getParameter(Parameters.PIN.parameterName());
		long accountNumber = (long) ServletUtil.session(request).getAttribute("accountNumber");
		try {
			Account account = Services.employeeOperations.closeAccount(accountNumber, employee.getUserId(), pin);
			request.setAttribute("status", true);
			request.setAttribute("message", "Account (Acc/No : " + accountNumber + ") has been successfully closed");

			// Log
			AuditLog log = new AuditLog();
			log.setUserId(employee.getUserId());
			log.setTargetId(account.getUserId());
			log.setLogOperation(LogOperation.CLOSE_ACCOUNT);
			log.setOperationStatus(OperationStatus.SUCCESS);
			log.setDescription("Account(Acc/No : " + account.getAccountNumber() + ") was closed by "
					+ employee.getType() + "(ID : " + employee.getUserId() + ")");
			log.setModifiedAt(account.getModifiedAt());
			Services.auditLogService.log(log);

		} catch (AppException e) {
			request.setAttribute("status", false);
			request.setAttribute("message", e.getMessage());

			// Log
			AuditLog log = new AuditLog();
			log.setUserId(employee.getUserId());
			log.setLogOperation(LogOperation.CLOSE_ACCOUNT);
			log.setOperationStatus(OperationStatus.FAILURE);
			log.setDescription("Account(Acc/No : " + accountNumber + ") close failed " + employee.getType() + "(ID : "
					+ employee.getUserId() + ") - " + e.getMessage());
			log.setModifiedAtWithCurrentTime();
			Services.auditLogService.log(log);

		}
		request.setAttribute("redirect", "branch_accounts");
		request.getRequestDispatcher("/WEB-INF/jsp/common/transaction_status.jsp").forward(request, response);
	}
}
