package com.cskbank.servlet;

import java.io.IOException;
import java.util.Objects;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cskbank.exceptions.AppException;
import com.cskbank.filters.Parameters;
import com.cskbank.modules.Account;
import com.cskbank.modules.AuditLog;
import com.cskbank.modules.CustomerRecord;
import com.cskbank.modules.EmployeeRecord;
import com.cskbank.modules.Transaction;
import com.cskbank.modules.UserRecord.Type;
import com.cskbank.utility.ConstantsUtil.Gender;
import com.cskbank.utility.ConstantsUtil.LogOperation;
import com.cskbank.utility.ConstantsUtil.OperationStatus;
import com.cskbank.utility.ConstantsUtil.TransactionType;
import com.cskbank.utility.ConvertorUtil;
import com.cskbank.utility.LogUtil;
import com.cskbank.utility.MailGenerationUtil;
import com.cskbank.utility.ServletUtil;
import com.cskbank.utility.ValidatorUtil;

class EmployeeServletHelper {

	public void accountDetailsGetRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, AppException {
		Long accountNumber = ConvertorUtil
				.convertStringToLong(request.getParameter(Parameters.ACCOUNTNUMBER.parameterName()));
		Account account = HandlerObject.getEmployeeHandler().getAccountDetails(accountNumber);
		CustomerRecord customer = HandlerObject.getEmployeeHandler().getCustomerRecord(account.getUserId());
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

		int branchId = employee.getBranchId();

		if (employee.getType() == Type.ADMIN) {
			String branchIdParam = request.getParameter(Parameters.BRANCHID.parameterName());
			if (!ValidatorUtil.isObjectNull(branchIdParam)) {
				branchId = ConvertorUtil.convertStringToInteger(branchIdParam);
			}
			if (pageCount <= 0) {
				pageCount = HandlerObject.getAdminHandler().getPageCountOfAccountsInBranch(branchId);
			}
			request.setAttribute("accounts",
					HandlerObject.getAdminHandler().getListOfAccountsInBranch(branchId, currentPage));
		} else {
			if (pageCount <= 0) {
				pageCount = HandlerObject.getEmployeeHandler().getBranchAccountsPageCount(employee.getUserId());
			}
			request.setAttribute("accounts",
					HandlerObject.getEmployeeHandler().getListOfAccountsInBranch(employee.getUserId(), currentPage));
		}

		request.setAttribute("currentPage", currentPage);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("branch", HandlerObject.getEmployeeHandler().getBrachDetails(branchId));
		request.getRequestDispatcher("/WEB-INF/jsp/employee/branch_accounts.jsp").forward(request, response);
	}

	public void searchPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {
		EmployeeRecord employee = (EmployeeRecord) ServletUtil.getUser(request);
		String searchBy = request.getParameter(Parameters.SEARCHBY.parameterName());
		String searchValue = request.getParameter(Parameters.SEARCHVALUE.parameterName());

		if (searchBy.equals("customerId")) {
			int userId = ConvertorUtil.convertStringToInteger(searchValue);
			request.setAttribute("customer",
					(CustomerRecord) HandlerObject.getEmployeeHandler().getCustomerRecord(userId));
			request.setAttribute("accounts",
					HandlerObject.getEmployeeHandler().getAssociatedAccountsOfCustomer(userId));
			request.getRequestDispatcher("/WEB-INF/jsp/employee/search_customer.jsp").forward(request, response);

			// Log
			AuditLog log = new AuditLog();
			log.setUserId(employee.getUserId());
			log.setTargetId(userId);
			log.setLogOperation(LogOperation.VIEW_CUSTOMER);
			log.setOperationStatus(OperationStatus.SUCCESS);
			log.setDescription("Customer details (ID : " + userId + ") was searched and viewed by " + employee.getType()
					+ " (ID :  " + employee.getUserId() + ")");
			log.setModifiedAtWithCurrentTime();
			HandlerObject.getAuditHandler().log(log);

		} else if (searchBy.equals("accountNumber")) {
			long accountNumber = ConvertorUtil.convertStringToLong(searchValue);
			Account account = HandlerObject.getEmployeeHandler().getAccountDetails(accountNumber);
			CustomerRecord customer = HandlerObject.getEmployeeHandler().getCustomerRecord(account.getUserId());
			request.setAttribute("account", account);
			request.setAttribute("customer", customer);
			request.getRequestDispatcher("/WEB-INF/jsp/employee/account_details.jsp").forward(request, response);

			// Log
			AuditLog log = new AuditLog();
			log.setUserId(employee.getUserId());
			log.setLogOperation(LogOperation.VIEW_ACCOUNT);
			log.setOperationStatus(OperationStatus.SUCCESS);
			log.setDescription("Account details (ID : " + accountNumber + ") was searched and viewed by "
					+ employee.getType() + " (ID :  " + employee.getUserId() + ")");
			log.setModifiedAtWithCurrentTime();
			HandlerObject.getAuditHandler().log(log);

		} else {
			throw new AppException("Invalid Search By Field Obtained");
		}
	}

	public void authorizeTransactionPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {

		long accountNumber = ConvertorUtil
				.convertStringToLong(request.getParameter(Parameters.ACCOUNTNUMBER.parameterName()));
		double amount = ConvertorUtil.convertStringToDouble(request.getParameter(Parameters.AMOUNT.parameterName()));
		TransactionType type = TransactionType
				.convertStringToEnum(request.getParameter(Parameters.TYPE.parameterName()));

		HandlerObject.getEmployeeHandler().getAccountDetails(accountNumber);
		ServletUtil.session(request).setAttribute("accountNumber", accountNumber);
		ServletUtil.session(request).setAttribute("amount", amount);
		ServletUtil.session(request).setAttribute("type", type);
		ServletUtil.session(request).setAttribute("redirect", "process_transaction");
		response.sendRedirect("authorization");
	}

	public void processTransactionPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {
		EmployeeRecord employee = (EmployeeRecord) ServletUtil.getUser(request);
		String pin = request.getParameter(Parameters.PIN.parameterName());
		long accountNumber = ServletUtil.getSessionObject(request, "accountNumber");
		double amount = ServletUtil.getSessionObject(request, "amount");
		TransactionType type = ServletUtil.getSessionObject(request, "type");

		try {
			Transaction transaction;
			if (type == TransactionType.CREDIT) {
				transaction = HandlerObject.getEmployeeHandler().depositAmount(employee.getUserId(), accountNumber,
						amount, pin);
			} else {
				transaction = HandlerObject.getEmployeeHandler().withdrawAmount(employee.getUserId(), accountNumber,
						amount, pin);
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
			HandlerObject.getAuditHandler().log(log);

		} catch (AppException e) {
			LogUtil.logException(e);

			request.setAttribute("status", false);
			request.setAttribute("message", e.getMessage());
			request.setAttribute("redirect", "transaction");

			// Log
			AuditLog log = new AuditLog();
			Account account = HandlerObject.getEmployeeHandler().getAccountDetails(accountNumber);
			log.setUserId(employee.getUserId());
			log.setTargetId(account.getUserId());
			log.setLogOperation(LogOperation.EMPLOYEE_TRANSACTION);
			log.setOperationStatus(OperationStatus.FAILURE);
			log.setDescription(employee.getType() + "(ID : " + employee.getUserId() + ") "
					+ (type == TransactionType.CREDIT ? "deposit" : "withdrawal") + "failed on Account(Acc/No : "
					+ accountNumber + ") - " + e.getMessage());
			log.setModifiedAtWithCurrentTime();
			HandlerObject.getAuditHandler().log(log);

		}
		request.getRequestDispatcher("/WEB-INF/jsp/common/transaction_status.jsp").forward(request, response);
	}

	public void authorizeOpenAccount(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {
		Account.AccountType accountType = ConvertorUtil.convertToEnum(Account.AccountType.class,
				request.getParameter(Parameters.TYPE.parameterName()));
		double amount = ConvertorUtil.convertStringToDouble(request.getParameter(Parameters.AMOUNT.parameterName()));
		String customerType = request.getParameter(Parameters.CUSTOMERTYPE.parameterName());

		if (customerType.equals("new")) {
			CustomerRecord newCustomer = new CustomerRecord();

			newCustomer.setFirstName(request.getParameter(Parameters.FIRSTNAME.parameterName()));
			newCustomer.setLastName(request.getParameter(Parameters.LASTNAME.parameterName()));
			newCustomer.setDateOfBirth(
					ConvertorUtil.dateStringToMillis(request.getParameter(Parameters.DATEOFBIRTH.parameterName())));
			newCustomer.setGender(
					ConvertorUtil.convertToEnum(Gender.class, request.getParameter(Parameters.GENDER.parameterName())));
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
			HandlerObject.getEmployeeHandler().getCustomerRecord(customerId);
			ServletUtil.session(request).setAttribute("customerId", customerId);
		}
		ServletUtil.session(request).setAttribute("accountType", accountType);
		ServletUtil.session(request).setAttribute("amount", amount);
		ServletUtil.session(request).setAttribute("customerType", customerType);
		ServletUtil.session(request).setAttribute("redirect", "process_open_account");
		response.sendRedirect("authorization");
	}

	public void processOpenAccountPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {
		EmployeeRecord employee = (EmployeeRecord) ServletUtil.getUser(request);

		String pin = request.getParameter(Parameters.PIN.parameterName());

		Account.AccountType accountType = ServletUtil.getSessionObject(request, "accountType");
		double amount = ServletUtil.getSessionObject(request, "amount");
		String customerType = ServletUtil.getSessionObject(request, "customerType");
		Account newAccount = null;
		try {
			if (customerType.equals("new")) {
				CustomerRecord newCustomer = ServletUtil.getSessionObject(request, "newCustomer");
				newAccount = HandlerObject.getEmployeeHandler().createNewCustomerAndAccount(newCustomer, accountType,
						amount, employee.getUserId(), pin);
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
				HandlerObject.getAuditHandler().log(log);

				MailGenerationUtil.sendUserCreationMail(newCustomer);
				log = new AuditLog();
				log.setUserId(employee.getUserId());
				log.setTargetId(newCustomer.getUserId());
				log.setLogOperation(LogOperation.CUSTOMER_CREATION_MAIL);
				log.setOperationStatus(OperationStatus.SUCCESS);
				log.setDescription("Customer Creation mail was sent to Customer(ID : " + employee.getUserId() + ")");
				log.setModifiedAtWithCurrentTime();
				HandlerObject.getAuditHandler().log(log);

			} else if (customerType.equals("existing")) {
				int customerId = ServletUtil.getSessionObject(request, "customerId");
				newAccount = HandlerObject.getEmployeeHandler().createAccountForExistingCustomer(customerId,
						accountType, amount, employee.getUserId(), pin);
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
			HandlerObject.getAuditHandler().log(log);

		} catch (Exception e) {
			LogUtil.logException(e);
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
			HandlerObject.getAuditHandler().log(log);

		}
		request.getRequestDispatcher("/WEB-INF/jsp/common/transaction_status.jsp").forward(request, response);
	}

	public void authorizeCloseAccountPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {
		long accountNumber = ConvertorUtil
				.convertStringToLong(request.getParameter(Parameters.ACCOUNTNUMBER.parameterName()));

		HandlerObject.getEmployeeHandler().getAccountDetails(accountNumber);
		ServletUtil.session(request).setAttribute("accountNumber", accountNumber);
		ServletUtil.session(request).setAttribute("redirect", "process_close_account");
		response.sendRedirect("authorization");
	}

	public void processCloseAccountPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {
		EmployeeRecord employee = (EmployeeRecord) ServletUtil.getUser(request);
		String pin = request.getParameter(Parameters.PIN.parameterName());
		long accountNumber = ServletUtil.getSessionObject(request, "accountNumber");
		try {
			Account account = HandlerObject.getEmployeeHandler().closeAccount(accountNumber, employee.getUserId(), pin);
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
			HandlerObject.getAuditHandler().log(log);

		} catch (AppException e) {
			LogUtil.logException(e);

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
			HandlerObject.getAuditHandler().log(log);

		}
		request.setAttribute("redirect", "branch_accounts");
		request.getRequestDispatcher("/WEB-INF/jsp/common/transaction_status.jsp").forward(request, response);
	}

	public void authorizeFreezeAccountPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {
		long accountNumber = ConvertorUtil
				.convertStringToLong(request.getParameter(Parameters.ACCOUNTNUMBER.parameterName()));

		HandlerObject.getEmployeeHandler().getUnclosedAccountDetails(accountNumber);
		ServletUtil.session(request).setAttribute("accountNumber", accountNumber);
		ServletUtil.session(request).setAttribute("redirect", "process_freeze_account");
		response.sendRedirect("authorization");
	}

	public void processFreezeAccountPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {
		EmployeeRecord employee = (EmployeeRecord) ServletUtil.getUser(request);
		String pin = request.getParameter(Parameters.PIN.parameterName());
		long accountNumber = ServletUtil.getSessionObject(request, "accountNumber");
		try {
			Account account = HandlerObject.getEmployeeHandler().freezeAccount(accountNumber, employee.getUserId(),
					pin);
			request.setAttribute("status", true);
			request.setAttribute("message", "Account (Acc/No : " + accountNumber + ") has been successfully frozen");

			// Log
			AuditLog log = new AuditLog();
			log.setUserId(employee.getUserId());
			log.setTargetId(account.getUserId());
			log.setLogOperation(LogOperation.CLOSE_ACCOUNT);
			log.setOperationStatus(OperationStatus.SUCCESS);
			log.setDescription("Account(Acc/No : " + account.getAccountNumber() + ") was frozen by "
					+ employee.getType() + "(ID : " + employee.getUserId() + ")");
			log.setModifiedAt(account.getModifiedAt());
			HandlerObject.getAuditHandler().log(log);

		} catch (AppException e) {
			LogUtil.logException(e);

			request.setAttribute("status", false);
			request.setAttribute("message", e.getMessage());

			// Log
			AuditLog log = new AuditLog();
			log.setUserId(employee.getUserId());
			log.setLogOperation(LogOperation.CLOSE_ACCOUNT);
			log.setOperationStatus(OperationStatus.FAILURE);
			log.setDescription("Account(Acc/No : " + accountNumber + ") freeze failed " + employee.getType() + "(ID : "
					+ employee.getUserId() + ") - " + e.getMessage());
			log.setModifiedAtWithCurrentTime();
			HandlerObject.getAuditHandler().log(log);

		}
		request.setAttribute("redirect", "branch_accounts");
		request.getRequestDispatcher("/WEB-INF/jsp/common/transaction_status.jsp").forward(request, response);
	}

}
