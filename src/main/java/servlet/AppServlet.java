package servlet;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import exceptions.AppException;
import exceptions.messages.ServletExceptionMessage;
import modules.Account;
import modules.Branch;
import modules.CustomerRecord;
import modules.EmployeeRecord;
import modules.Transaction;
import modules.UserRecord;
import operations.AppOperations;
import operations.CustomerOperations;
import operations.EmployeeOperations;
import utility.ConstantsUtil.AccountType;
import utility.ConstantsUtil.ModifiableField;
import utility.ConstantsUtil.Status;
import utility.ConstantsUtil.TransactionHistoryLimit;
import utility.ConstantsUtil.TransactionType;
import utility.ConstantsUtil.UserType;
import utility.ConvertorUtil;
import utility.ValidatorUtil;

public class AppServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private CustomerOperations customerOperation;
	private EmployeeOperations employeeOperation;
	private CommonServletHandlers commonServletHandler;

	public AppServlet() throws AppException {
		customerOperation = new CustomerOperations();
		employeeOperation = new EmployeeOperations();
		commonServletHandler = new CommonServletHandlers();
	}

	private HttpSession session(HttpServletRequest request) throws ServletException, IOException {
		return request.getSession(false);
	}

	private void dispatchRequest(HttpServletRequest request, HttpServletResponse response, String url)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}

	private UserRecord getUser(HttpServletRequest request, HttpServletResponse response)
			throws AppException, ServletException, IOException {
		HttpSession currentSession = session(request);
		return (UserRecord) currentSession.getAttribute("user");
	}

	private String nextURL(HttpServletRequest request, String url) {
		return request.getContextPath() + request.getServletPath() + url;
	}

	private String getStringFromParameter(HttpServletRequest request, String parameter) throws AppException {
		ValidatorUtil.validateObject(parameter);
		ValidatorUtil.validateObject(request);
		String parameterValue = request.getParameter(parameter);
		if (Objects.isNull(parameterValue)) {
			throw new AppException(parameter, ServletExceptionMessage.INVALID_VALUE);
		}
		return parameterValue;
	}

	private int getIntFromParameter(HttpServletRequest request, String parameter) throws AppException {
		ValidatorUtil.validateObject(parameter);
		ValidatorUtil.validateObject(request);
		String parameterValue = request.getParameter(parameter);
		try {
			return Integer.parseInt(parameterValue);
		} catch (Exception e) {
			throw new AppException(parameter, ServletExceptionMessage.INVALID_VALUE);
		}
	}

	private long getLongFromParameter(HttpServletRequest request, String parameter) throws AppException {
		ValidatorUtil.validateObject(parameter);
		ValidatorUtil.validateObject(request);
		String parameterValue = request.getParameter(parameter);
		try {
			return Long.parseLong(parameterValue);
		} catch (Exception e) {
			throw new AppException(parameter, ServletExceptionMessage.INVALID_VALUE);
		}
	}

	private double getDoubleFromParameter(HttpServletRequest request, String parameter) throws AppException {
		ValidatorUtil.validateObject(parameter);
		ValidatorUtil.validateObject(request);
		String parameterValue = request.getParameter(parameter);
		try {
			return Double.parseDouble(parameterValue);
		} catch (Exception e) {
			throw new AppException(parameter, ServletExceptionMessage.INVALID_AMOUNT);
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String path = request.getPathInfo();
		try {
			if (path.startsWith("/customer")) {
				customerPostController(request, response, path);
			} else if (path.startsWith("/employee")) {
				employeePostController(request, response, path);
			} else {
				switch (path) {
				case "/login": {
					commonServletHandler.loginPostRequest(request, response);
				}
					break;

				default:
					dispatchRequest(request, response, "/static/html/page_not_found.html");
					break;
				}
			}
		} catch (

		AppException e) {
			session(request).setAttribute("error", e.getMessage());
			response.sendRedirect("home");
		}
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String path = request.getPathInfo();
		try {
			if (path.contains("/logout")) {
				request.getSession().invalidate();
				response.sendRedirect(request.getContextPath() + "/app/login");
			} else if (path.startsWith("/customer")) {
				customerGetController(request, response, path);
			} else if (path.startsWith("/employee")) {
				employeeGetController(request, response, path);
			} else {
				switch (path) {
				case "/login": {
					request.getSession().invalidate();
					dispatchRequest(request, response, "/WEB-INF/jsp/login.jsp");
				}
					break;

				default:
					dispatchRequest(request, response, "/static/html/page_not_found.html");
					break;

				}
			}
		} catch (AppException e) {
			session(request).setAttribute("error", e.getMessage());
			response.sendRedirect("home");
		}
	}

	private void customerGetController(HttpServletRequest request, HttpServletResponse response, String path)
			throws AppException, ServletException, IOException {
		CustomerRecord customer = (CustomerRecord) getUser(request, response);
		if (Objects.isNull(customer)) {
			response.sendRedirect(nextURL(request, "/login"));
			return;
		}
		switch (path) {
		case "/customer/home":
		case "/customer/account": {

			request.setAttribute("accounts", customerOperation.getAssociatedAccounts(customer.getUserId()));
			dispatchRequest(request, response, "/WEB-INF/jsp/customer/accounts.jsp");
		}
			break;

		case "/customer/account_details": {
			Long accountNumber = getLongFromParameter(request, "account_number");
			Account account = customerOperation.getAccountDetails(accountNumber, customer.getUserId());
			Branch branch = customerOperation.getBranchDetailsOfAccount(account.getBranchId());
			request.setAttribute("account", account);
			request.setAttribute("branch", branch);
			dispatchRequest(request, response, "/WEB-INF/jsp/customer/account_details.jsp");
		}
			break;

		case "/customer/statement": {
			Map<Long, Account> accounts = (Map<Long, Account>) customerOperation
					.getAssociatedAccounts(customer.getUserId());
			request.setAttribute("accounts", accounts);
			dispatchRequest(request, response, "/WEB-INF/jsp/common/statement_select.jsp");
		}
			break;

		case "/customer/transfer": {
			Map<Long, Account> accounts = (Map<Long, Account>) customerOperation
					.getAssociatedAccounts(customer.getUserId());
			request.setAttribute("accounts", accounts);
			dispatchRequest(request, response, "/WEB-INF/jsp/customer/transfer.jsp");
		}
			break;

		case "/customer/change_password": {
			dispatchRequest(request, response, "/WEB-INF/jsp/customer/change_password.jsp");
		}
			break;

		case "/customer/profile": {
			dispatchRequest(request, response, "/WEB-INF/jsp/customer/profile.jsp");
		}
			break;
		case "/customer/profile_edit": {
			dispatchRequest(request, response, "/WEB-INF/jsp/customer/profile_edit.jsp");
		}
			break;

		default:
			dispatchRequest(request, response, "/static/html/page_not_found.html");
			break;
		}
	}

	private void customerPostController(HttpServletRequest request, HttpServletResponse response, String path)
			throws AppException, ServletException, IOException {
		CustomerRecord customer = (CustomerRecord) getUser(request, response);
		if (Objects.isNull(customer)) {
			response.sendRedirect(nextURL(request, "/login"));
			return;
		}
		switch (path) {
		case "/customer/statement":
			commonServletHandler.statementPostRequest(request, response);
			break;

		case "/customer/authorization": {
			String operation = getStringFromParameter(request, "operation");
			switch (operation) {
			case "authorize_transaction": {
				long viewer_account_number = getLongFromParameter(request, "from-account");
				long transacted_account_number = getLongFromParameter(request, "to-account");
				double amount = getDoubleFromParameter(request, "amount");
				String transferWithinBankString = getStringFromParameter(request, "transferWithinBank");
				boolean transferWithinBank = !Objects.isNull(transferWithinBankString);
				String ifsc = getStringFromParameter(request, "ifsc");
				String remarks = getStringFromParameter(request, "remarks");

				Transaction transaction = new Transaction();
				transaction.setViewerAccountNumber(viewer_account_number);
				transaction.setTransactedAccountNumber(transacted_account_number);
				transaction.setTransactedAmount(amount);
				transaction.setRemarks(remarks);
				transaction.setUserId(customer.getUserId());

				session(request).setAttribute("transaction", transaction);
				session(request).setAttribute("transferWithinBank", transferWithinBank);
				RequestDispatcher dispatcher = request
						.getRequestDispatcher("/WEB-INF/jsp/customer/authorization.jsp?redirect=process_transaction");
				dispatcher.forward(request, response);
			}
				break;

			case "process_transaction": {
				String pin = getStringFromParameter(request, "pin");
				Transaction transaction = (Transaction) session(request).getAttribute("transaction");
				session(request).removeAttribute("transaction");
				boolean transferWithinBank = (boolean) session(request).getAttribute("transferWithinBank");
				session(request).removeAttribute("transferWithinBank");

				try {
					long transactionId = customerOperation.tranferMoney(transaction, transferWithinBank, pin);
					request.setAttribute("status", true);
					request.setAttribute("operation", "transaction");
					request.setAttribute("message",
							"Your Transaction has been completed!\n Tranaction ID : " + transactionId);
					request.setAttribute("redirect", "account");
				} catch (AppException e) {
					e.printStackTrace();
					request.setAttribute("status", false);
					request.setAttribute("operation", "transaction");
					request.setAttribute("message", e.getMessage());
					request.setAttribute("redirect", "transfer");
				}
				RequestDispatcher dispatcher = request
						.getRequestDispatcher("/WEB-INF/jsp/customer/transaction_status.jsp");
				dispatcher.forward(request, response);
			}
				break;

			case "authorize_change_password":
				commonServletHandler.passwordChangeAuthorizationPostRequest(request, response);
				break;

			case "process_change_password":
				commonServletHandler.passwordChangeProcessPostRequest(request, response);
				break;

			case "authorize_profile_update": {
				String oldAddress = (String) getStringFromParameter(request, "old_address");
				String newAddress = (String) getStringFromParameter(request, "new_address");
				String oldEmail = (String) getStringFromParameter(request, "old_email");
				String newEmail = (String) getStringFromParameter(request, "new_email");
				boolean addressChangeNeeded = !oldAddress.equals(newAddress);
				boolean emailChangeNeeded = !oldEmail.equals(newEmail);
				String url = "authorization.jsp?redirect=process_profile_update";
				if (!addressChangeNeeded && !emailChangeNeeded) {
					response.sendRedirect(nextURL(request, "/customer/profile"));
					return;
				} else {
					List<ModifiableField> fields = new ArrayList<>();
					if (addressChangeNeeded) {
						request.getSession(false).setAttribute("address", newAddress);
						fields.add(ModifiableField.ADDRESS);
					}
					if (emailChangeNeeded) {
						request.getSession(false).setAttribute("email", newEmail);
						fields.add(ModifiableField.EMAIL);
					}
					request.getSession(false).setAttribute("fields", fields);
				}
				RequestDispatcher dispatch = request.getRequestDispatcher("/WEB-INF/jsp/customer/" + url);
				dispatch.forward(request, response);
			}
				break;

			case "process_profile_update": {
				String pin = (String) getStringFromParameter(request, "pin");
				try {
					List<ModifiableField> fields = (List<ModifiableField>) session(request).getAttribute("fields");
					int customerId = customer.getUserId();
					for (ModifiableField field : fields) {
						Object value = session(request).getAttribute(field.toString().toLowerCase());
						customerOperation.updateUserDetails(customerId, field, value, pin);
					}
					CustomerRecord user = customerOperation.getCustomerRecord(customerId);
					System.out.println(user.getAddress());
					session(request).setAttribute("user", user);
					request.setAttribute("status", true);
					request.setAttribute("operation", "profile_update");
					request.setAttribute("message",
							"The profile details have been updated\nThe changes will be reflected shortly");
					request.setAttribute("redirect", "profile");
				} catch (AppException e) {
					e.printStackTrace();
					request.setAttribute("status", true);
					request.setAttribute("operation", "profile_update");
					request.setAttribute("message", "An error occured. " + e.getMessage());
					request.setAttribute("redirect", "profile");
				}
				RequestDispatcher dispatcher = request
						.getRequestDispatcher("/WEB-INF/jsp/customer/transaction_status.jsp");
				dispatcher.forward(request, response);
			}
				break;

			default:
				dispatchRequest(request, response, "/static/html/page_not_found.html");
				break;
			}
		}
			break;

		default:
			dispatchRequest(request, response, "/static/html/page_not_found.html");
			break;
		}
	}

	private void employeeGetController(HttpServletRequest request, HttpServletResponse response, String path)
			throws IOException, AppException, ServletException {
		EmployeeRecord employee = (EmployeeRecord) getUser(request, response);
		if (Objects.isNull(employee)) {
			response.sendRedirect(nextURL(request, "/login"));
			return;
		}
		switch (path) {
		case "/employee/home":
		case "/employee/branch_accounts": {

			int pageCount = employeeOperation.getBranchAccountsPageCount(employee.getBranchId());
			System.out.println(pageCount);
			request.setAttribute("accounts", employeeOperation.getListOfAccountsInBranch(employee.getUserId(), 1));
			request.setAttribute("currentPage", 1);
			request.setAttribute("pageCount", pageCount);
			request.setAttribute("branch", employeeOperation.getBrachDetails(employee.getBranchId()));
			dispatchRequest(request, response, "/WEB-INF/jsp/employee/branch_accounts.jsp");
		}
			break;

		case "/employee/account_details": {
			Long accountNumber = getLongFromParameter(request, "account_number");
			Account account = employeeOperation.getAccountDetails(accountNumber);
			CustomerRecord customer = employeeOperation.getCustomerRecord(account.getUserId());
			request.setAttribute("account", account);
			request.setAttribute("customer", customer);
			dispatchRequest(request, response, "/WEB-INF/jsp/employee/account_details.jsp");
		}
			break;

		case "/employee/account_details_edit": {
			Long accountNumber = getLongFromParameter(request, "account_number");
			Account account = employeeOperation.getAccountDetails(accountNumber);
			CustomerRecord customer = employeeOperation.getCustomerRecord(account.getUserId());
			request.setAttribute("account", account);
			request.setAttribute("customer", customer);
			dispatchRequest(request, response, "/WEB-INF/jsp/employee/account_details_edit.jsp");
		}
			break;

		case "/employee/open_account": {
			dispatchRequest(request, response, "/WEB-INF/jsp/employee/open_account.jsp");
		}
			break;

		case "/employee/statement": {
			if (!Objects.isNull(request.getParameter("accountNumber"))) {
				long accountNumber = getLongFromParameter(request, "accountNumber");
				request.setAttribute("accountNumber", accountNumber);
			}
			dispatchRequest(request, response, "/WEB-INF/jsp/common/statement_select.jsp");
		}
			break;

		case "/employee/transaction": {
			dispatchRequest(request, response, "/WEB-INF/jsp/employee/transaction.jsp");
		}
			break;

		case "/employee/change_password": {
			dispatchRequest(request, response, "/WEB-INF/jsp/employee/change_password.jsp");
		}
			break;

		case "/employee/profile": {
			dispatchRequest(request, response, "/WEB-INF/jsp/employee/profile.jsp");
		}
			break;
		case "/employee/profile_edit": {
			dispatchRequest(request, response, "/WEB-INF/jsp/employee/profile_edit.jsp");
		}
			break;

		default:
			dispatchRequest(request, response, "/static/html/page_not_found.html");
			break;
		}
	}

	private void employeePostController(HttpServletRequest request, HttpServletResponse response, String path)
			throws AppException, ServletException, IOException {
		EmployeeRecord employee = (EmployeeRecord) getUser(request, response);
		if (Objects.isNull(employee)) {
			response.sendRedirect(nextURL(request, "/login"));
			return;
		}
		switch (path) {
		case "/employee/branch_accounts": {
			Map<String, String[]> parameters = request.getParameterMap();
			if (parameters.containsKey("pageCount") && parameters.containsKey("currentPage")) {
				int pageCount = getIntFromParameter(request, "pageCount");
				int currentPage = getIntFromParameter(request, "currentPage");
				request.setAttribute("accounts",
						employeeOperation.getListOfAccountsInBranch(employee.getUserId(), currentPage));
				request.setAttribute("currentPage", currentPage);
				request.setAttribute("pageCount", pageCount);
			} else {
				int pageCount = employeeOperation.getBranchAccountsPageCount(employee.getBranchId());
				request.setAttribute("accounts", employeeOperation.getListOfAccountsInBranch(employee.getUserId(), 1));
				request.setAttribute("currentPage", 1);
				request.setAttribute("pageCount", pageCount);
			}
			request.setAttribute("branch", employeeOperation.getBrachDetails(employee.getBranchId()));
			dispatchRequest(request, response, "/WEB-INF/jsp/employee/branch_accounts.jsp");
		}
			break;

		case "/employee/statement": {
			commonServletHandler.statementPostRequest(request, response);
		}
			break;

		case "/employee/authorization": {
			String operation = getStringFromParameter(request, "operation");
			switch (operation) {
			case "authorize_transaction": {
				long accountNumber = getLongFromParameter(request, "accountNumber");
				double amount = getDoubleFromParameter(request, "amount");
				TransactionType type = TransactionType.valueOf(getStringFromParameter(request, "type"));
				session(request).setAttribute("accountNumber", accountNumber);
				session(request).setAttribute("amount", amount);
				session(request).setAttribute("type", type);
				dispatchRequest(request, response,
						"/WEB-INF/jsp/customer/authorization.jsp?redirect=process_transaction");
			}
				break;

			case "process_transaction": {
				String pin = getStringFromParameter(request, "pin");
				long accountNumber = (long) session(request).getAttribute("accountNumber");
				double amount = (double) session(request).getAttribute("amount");
				TransactionType type = (TransactionType) session(request).getAttribute("type");

				try {
					long transactionId = 0;
					if (type == TransactionType.CREDIT) {
						transactionId = employeeOperation.depositAmount(employee.getUserId(), accountNumber, amount,
								pin);
					} else {
						transactionId = employeeOperation.withdrawAmount(employee.getUserId(), accountNumber, amount,
								pin);
					}
					request.setAttribute("status", true);
					request.setAttribute("operation", "transaction");
					request.setAttribute("message",
							"Your Transaction has been completed!<br>Tranaction ID : " + transactionId);
					request.setAttribute("redirect", "branch_accounts");
				} catch (AppException e) {
					e.printStackTrace();
					request.setAttribute("status", false);
					request.setAttribute("operation", "transaction");
					request.setAttribute("message", e.getMessage());
					request.setAttribute("redirect", "transaction");
				}
				RequestDispatcher dispatcher = request
						.getRequestDispatcher("/WEB-INF/jsp/customer/transaction_status.jsp");
				dispatcher.forward(request, response);
			}
				break;

			case "authorize_open_account": {
				AccountType accountType = AccountType.valueOf(getStringFromParameter(request, "type"));
				double amount = getDoubleFromParameter(request, "amount");
				String customerType = getStringFromParameter(request, "customer");
				try {
					if (customerType.equals("new")) {
						CustomerRecord newCustomer = new CustomerRecord();
						newCustomer.setFirstName(getStringFromParameter(request, "firstName"));
						newCustomer.setLastName(getStringFromParameter(request, "lastName"));
						newCustomer.setDateOfBirth(
								ConvertorUtil.dateStringToMillis(getStringFromParameter(request, "dateOfBirth")));
						newCustomer.setGender(getIntFromParameter(request, "gender"));
						newCustomer.setAddress(getStringFromParameter(request, "address"));
						newCustomer.setPhone(getLongFromParameter(request, "mobile"));
						newCustomer.setEmail(getStringFromParameter(request, "email"));
						newCustomer.setAadhaarNumber(getLongFromParameter(request, "aadhar"));
						newCustomer.setPanNumber(getStringFromParameter(request, "pan"));
						session(request).setAttribute("newCustomer", newCustomer);
					} else if (customerType.equals("existing")) {
						int customerId = getIntFromParameter(request, "userId");
						employeeOperation.getCustomerRecord(customerId);
						session(request).setAttribute("customerId", customerId);
					}
					session(request).setAttribute("accountType", accountType);
					session(request).setAttribute("amount", amount);
					session(request).setAttribute("customerType", customerType);
					dispatchRequest(request, response,
							"/WEB-INF/jsp/customer/authorization.jsp?redirect=process_open_account");
				} catch (AppException e) {
					session(request).setAttribute("error", e.getMessage());
					dispatchRequest(request, response, "/WEB-INF/jsp/employee/open_account.jsp");
				}
			}
				break;

			case "process_open_account": {
				String pin = getStringFromParameter(request, "pin");
				AccountType accountType = (AccountType) session(request).getAttribute("accountType");
				double amount = (double) session(request).getAttribute("amount");
				String customerType = (String) session(request).getAttribute("customerType");
				try {
					if (customerType.equals("new")) {
						CustomerRecord newCustomer = (CustomerRecord) session(request).getAttribute("newCustomer");
						Account newAccount = employeeOperation.createNewCustomerAndAccount(newCustomer, accountType,
								amount, employee.getUserId(), pin);
						request.setAttribute("message", "New customer and account has been created\nCustomer ID : "
								+ newCustomer.getUserId() + "\nAccount Number : " + newAccount.getAccountNumber());
					} else if (customerType.equals("existing")) {
						int customerId = (int) session(request).getAttribute("customerId");
						Account newAccount = employeeOperation.createAccountForExistingCustomer(customerId, accountType,
								amount, employee.getUserId(), pin);
						request.setAttribute("message",
								"New account has been created\nAccount Number : " + newAccount.getAccountNumber());
					}
					request.setAttribute("status", true);
					request.setAttribute("redirect", "branch_accounts");

				} catch (AppException e) {
					request.setAttribute("status", false);
					request.setAttribute("redirect", "open_account");
					request.setAttribute("message", e.getMessage());
				}
				request.setAttribute("operation", "open_account");
				dispatchRequest(request, response, "/WEB-INF/jsp/customer/transaction_status.jsp");
			}
				break;
			case "authorize_change_password":
				commonServletHandler.passwordChangeAuthorizationPostRequest(request, response);
				break;

			case "process_change_password":
				commonServletHandler.passwordChangeProcessPostRequest(request, response);
				break;

			case "authorize_close_account": {
				long accountNumber = getLongFromParameter(request, "accountNumber");
				try {
					employeeOperation.getAccountDetails(accountNumber);
					session(request).setAttribute("accountNumber", accountNumber);
					dispatchRequest(request, response,
							"/WEB-INF/jsp/common/authorization.jsp?redirect=process_close_account");
				} catch (AppException e) {
					request.setAttribute("status", false);
					request.setAttribute("message", e.getMessage());
					request.setAttribute("operation", "close_account");
					request.setAttribute("redirect", "branch_accounts");
					dispatchRequest(request, response, "/WEB-INF/jsp/common/transaction_status.jsp");
				}
			}
				break;

			case "process_close_account": {
				String pin = getStringFromParameter(request, "pin");
				long accountNumber = (long) session(request).getAttribute("accountNumber");
				try {
					employeeOperation.closeAccount(accountNumber, employee.getUserId(), pin);
					request.setAttribute("status", true);
					request.setAttribute("message",
							"Account (Acc/No : " + accountNumber + ") has been successfully closed");
				} catch (AppException e) {
					request.setAttribute("status", false);
					request.setAttribute("message", e.getMessage());
				}
				request.setAttribute("redirect", "branch_accounts");
				request.setAttribute("operation", "close_account");
				dispatchRequest(request, response, "/WEB-INF/jsp/customer/transaction_status.jsp");
			}
				break;

			default:
				dispatchRequest(request, response, "/static/html/page_not_found.html");
				break;
			}
			break;
		}
		default:
			dispatchRequest(request, response, "/static/html/page_not_found.html");
			break;
		}
	}
}
