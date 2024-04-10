package servlet;

import java.io.IOException;
import java.util.Objects;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import exceptions.AppException;
import filters.Parameters;
import modules.Account;
import modules.CustomerRecord;
import modules.EmployeeRecord;
import modules.Transaction;
import operations.AppOperations;
import operations.EmployeeOperations;
import utility.ConstantsUtil.AccountType;
import utility.ConstantsUtil.LogOperation;
import utility.ConstantsUtil.OperationStatus;
import utility.ConstantsUtil.TransactionType;
import utility.ConstantsUtil.UserType;
import utility.ConvertorUtil;
import utility.ServletUtil;

public class EmployeeControllerMethods {
	public EmployeeControllerMethods() throws AppException {
	}

	private EmployeeOperations operations = new EmployeeOperations();
	private AppOperations appOperations = new AppOperations();

	public void accountDetailsGetRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		EmployeeRecord employee = (EmployeeRecord) ServletUtil.getUser(request);
		try {
			Long accountNumber = ConvertorUtil
					.convertStringToLong(request.getParameter(Parameters.ACCOUNTNUMBER.parameterName()));
			Account account = operations.getAccountDetails(accountNumber);
			CustomerRecord customer = operations.getCustomerRecord(account.getUserId());
			request.setAttribute("account", account);
			request.setAttribute("customer", customer);
			request.getRequestDispatcher("/WEB-INF/jsp/employee/account_details.jsp").forward(request, response);
		} catch (AppException e) {
			ServletUtil.session(request).setAttribute("error", e.getMessage());
			response.sendRedirect(employee.getType() == UserType.ADMIN ? "accounts" : "branch_accounts");
		}
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
			pageCount = operations.getBranchAccountsPageCount(employee.getUserId());
		}
		request.setAttribute("accounts", operations.getListOfAccountsInBranch(employee.getUserId(), currentPage));
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("branch", operations.getBrachDetails(employee.getBranchId()));
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
				request.setAttribute("customer", (CustomerRecord) operations.getCustomerRecord(userId));
				request.setAttribute("accounts", operations.getAssociatedAccountsOfCustomer(userId));
				request.getRequestDispatcher("/WEB-INF/jsp/employee/search_customer.jsp").forward(request, response);

				// Log
				appOperations.logOperationByUser(employee.getUserId(), userId, LogOperation.VIEW_CUSTOMER,
						OperationStatus.SUCCESS, "Customer details (ID : " + userId + ") was searched and viewed by "
								+ employee.getType() + " (ID :  " + employee.getUserId() + ")",
						System.currentTimeMillis());
			} else if (searchBy.equals("accountNumber")) {
				long accountNumber = ConvertorUtil.convertStringToLong(searchValue);
				Account account = operations.getAccountDetails(accountNumber);
				CustomerRecord customer = operations.getCustomerRecord(account.getUserId());
				request.setAttribute("account", account);
				request.setAttribute("customer", customer);
				request.getRequestDispatcher("/WEB-INF/jsp/employee/search_account.jsp").forward(request, response);
				// Log
				appOperations
						.logOperationByAndForUser(employee.getUserId(), LogOperation.VIEW_ACCOUNT,
								OperationStatus.SUCCESS,
								"Account details (ID : " + accountNumber + ") was searched and viewed by "
										+ employee.getType() + " (ID :  " + employee.getUserId() + ")",
								System.currentTimeMillis());
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
			TransactionType type = TransactionType.valueOf(request.getParameter(Parameters.TYPE.parameterName()));

			operations.getAccountDetails(accountNumber);
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
				transaction = operations.depositAmount(employee.getUserId(), accountNumber, amount, pin);
			} else {
				transaction = operations.withdrawAmount(employee.getUserId(), accountNumber, amount, pin);
			}
			request.setAttribute("status", true);
			request.setAttribute("message",
					"Your Transaction has been completed!<br>Tranaction ID : " + transaction.getTransactionId());
			request.setAttribute("redirect", "branch_accounts");

			// Log
			appOperations.logOperationByUser(employee.getUserId(), transaction.getUserId(),
					LogOperation.EMPLOYEE_TRANSACTION, OperationStatus.SUCCESS,
					employee.getType() + " (ID : " + employee.getUserId() + ") has "
							+ (transaction.getTransactionType() == TransactionType.CREDIT ? "deposited " : "withdrawn ")
							+ ConvertorUtil.amountToCurrencyFormat(transaction.getTransactedAmount())
							+ " from Account(Acc/No : " + accountNumber + ")",
					transaction.getCreatedAt());
		} catch (AppException e) {
			request.setAttribute("status", false);
			request.setAttribute("message", e.getMessage());
			request.setAttribute("redirect", "transaction");

			// Log
			Account account = operations.getAccountDetails(accountNumber);
			appOperations.logOperationByUser(employee.getUserId(), account.getUserId(),
					LogOperation.EMPLOYEE_TRANSACTION, OperationStatus.FAILURE,
					employee.getType() + "(ID : " + employee.getUserId() + ") "
							+ (type == TransactionType.CREDIT ? "deposit" : "withdrawal")
							+ "failed on Account(Acc/No : " + accountNumber + ") - " + e.getMessage(),
					System.currentTimeMillis());
		}
		request.getRequestDispatcher("/WEB-INF/jsp/common/transaction_status.jsp").forward(request, response);
	}

	public void authorizeOpenAccount(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {
		AccountType accountType = AccountType.valueOf(request.getParameter(Parameters.TYPE.parameterName()));
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
				operations.getCustomerRecord(customerId);
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
		AccountType accountType = (AccountType) ServletUtil.session(request).getAttribute("accountType");
		double amount = (double) ServletUtil.session(request).getAttribute("amount");
		String customerType = (String) ServletUtil.session(request).getAttribute("customerType");
		Account newAccount = null;
		try {
			if (customerType.equals("new")) {
				CustomerRecord newCustomer = (CustomerRecord) ServletUtil.session(request).getAttribute("newCustomer");
				newAccount = operations.createNewCustomerAndAccount(newCustomer, accountType, amount,
						employee.getUserId(), pin);
				request.setAttribute("message", "New customer and account has been created\nCustomer ID : "
						+ newCustomer.getUserId() + "\nAccount Number : " + newAccount.getAccountNumber());

				// Log
				appOperations.logOperationByUser(
						employee.getUserId(), newCustomer.getUserId(), LogOperation.CREATE_CUSTOMER,
						OperationStatus.SUCCESS, "Customer(ID : " + newCustomer.getUserId() + ") was created by "
								+ employee.getType() + "(ID : " + employee.getUserId() + ")",
						newCustomer.getCreatedAt());
			} else if (customerType.equals("existing")) {
				int customerId = (int) ServletUtil.session(request).getAttribute("customerId");
				newAccount = operations.createAccountForExistingCustomer(customerId, accountType, amount,
						employee.getUserId(), pin);
				request.setAttribute("message",
						"New account has been created\nAccount Number : " + newAccount.getAccountNumber());
			}
			// Log
			appOperations.logOperationByUser(employee.getUserId(), newAccount.getUserId(), LogOperation.CREATE_ACCOUNT,
					OperationStatus.SUCCESS, "Account(Acc/No : " + newAccount.getAccountNumber() + ") was created by "
							+ employee.getType() + "(ID : " + employee.getUserId() + ")",
					newAccount.getCreatedAt());

			request.setAttribute("status", true);
			request.setAttribute("redirect", "branch_accounts");

		} catch (AppException e) {
			request.setAttribute("status", false);
			request.setAttribute("redirect", "open_account");
			request.setAttribute("message", e.getMessage());
			appOperations
					.logOperationByUser(
							employee.getUserId(), newAccount.getUserId(), LogOperation.CREATE_CUSTOMER_AND_ACCOUNT,
							OperationStatus.FAILURE, "Create customer and open account failed " + employee.getType()
									+ "(ID : " + employee.getUserId() + ") - " + e.getMessage(),
							System.currentTimeMillis());
		}
		request.getRequestDispatcher("/WEB-INF/jsp/common/transaction_status.jsp").forward(request, response);
	}

	public void authorizeCloseAccountPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {
		EmployeeRecord employee = (EmployeeRecord) ServletUtil.getUser(request);
		long accountNumber = ConvertorUtil
				.convertStringToLong(request.getParameter(Parameters.ACCOUNTNUMBER.parameterName()));
		try {
			operations.getAccountDetails(accountNumber);
			ServletUtil.session(request).setAttribute("accountNumber", accountNumber);
			request.getRequestDispatcher("/WEB-INF/jsp/common/authorization.jsp?redirect=process_close_account")
					.forward(request, response);
		} catch (AppException e) {
			ServletUtil.session(request).setAttribute("error", e.getMessage());
			response.sendRedirect(employee.getType() == UserType.ADMIN ? "accounts" : "branch_accounts");
		}
	}

	public void processCloseAccountPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {
		EmployeeRecord employee = (EmployeeRecord) ServletUtil.getUser(request);
		String pin = request.getParameter(Parameters.PIN.parameterName());
		long accountNumber = (long) ServletUtil.session(request).getAttribute("accountNumber");
		try {
			Account account = operations.closeAccount(accountNumber, employee.getUserId(), pin);
			request.setAttribute("status", true);
			request.setAttribute("message", "Account (Acc/No : " + accountNumber + ") has been successfully closed");

			appOperations
					.logOperationByUser(employee.getUserId(), account.getUserId(), LogOperation.CLOSE_ACCOUNT,
							OperationStatus.SUCCESS, "Account(Acc/No : " + account.getAccountNumber()
									+ ") was closed by " + employee.getType() + "(ID : " + employee.getUserId() + ")",
							account.getModifiedAt());
		} catch (AppException e) {
			request.setAttribute("status", false);
			request.setAttribute("message", e.getMessage());
			appOperations.logOperationByAndForUser(employee.getUserId(), LogOperation.CLOSE_ACCOUNT,
					OperationStatus.FAILURE, "Account(Acc/No : " + accountNumber + ") close failed "
							+ employee.getType() + "(ID : " + employee.getUserId() + ") - " + e.getMessage(),
					System.currentTimeMillis());
		}
		request.setAttribute("redirect", "branch_accounts");
		request.getRequestDispatcher("/WEB-INF/jsp/common/transaction_status.jsp").forward(request, response);
	}
}
