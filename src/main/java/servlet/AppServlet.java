package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import exceptions.AppException;
import modules.Account;
import modules.Branch;
import modules.CustomerRecord;
import modules.EmployeeRecord;
import modules.Transaction;
import operations.AdminOperations;
import operations.CustomerOperations;
import operations.EmployeeOperations;
import utility.ConstantsUtil.AccountType;
import utility.ConstantsUtil.ModifiableField;
import utility.ConstantsUtil.TransactionType;
import utility.ConstantsUtil.UserType;
import utility.ConvertorUtil;

public class AppServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private ServletUtil commonServletHandler;

	public AppServlet() throws AppException {
		commonServletHandler = new ServletUtil();
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String path = request.getPathInfo();
		try {
			if (path.startsWith("/customer")) {
				customerPostController(request, response, path);
			} else if (path.startsWith("/employee")) {
				path = path.replaceAll("^\\/.*\\/", "");
				employeePostController(request, response, path);
			} else if (path.startsWith("/admin")) {
				path = path.replaceAll("^\\/.*\\/", "");
				adminPostController(request, response, path);
				employeePostController(request, response, path);
			} else {
				switch (path) {
				case "/login": {
					commonServletHandler.loginPostRequest(request, response);
				}
					break;

				default:
					ServletUtil.dispatchRequest(request, response, "/static/html/page_not_found.html");
					break;
				}
			}
		} catch (AppException e) {
			ServletUtil.session(request).setAttribute("error", e.getMessage());
			ServletUtil.dispatchRequest(request, response,
					request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
							+ ServletUtil.nextURL(request, "/login"));

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
			} else if (path.startsWith("/customer")) {
				customerGetController(request, response, path);
			} else if (path.startsWith("/employee")) {
				path = path.replaceAll("^\\/.*\\/", "");
				employeeGetController(request, response, path);
			} else if (path.startsWith("/admin")) {
				path = path.replaceAll("^\\/.*\\/", "");
				adminGetController(request, response, path);
				employeeGetController(request, response, path);
			} else {
				switch (path) {
				case "/login": {
					request.getSession().invalidate();
					ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/login.jsp");
				}
					break;

				default:
					ServletUtil.dispatchRequest(request, response, "/static/html/page_not_found.html");
					break;
				}
			}
		} catch (AppException e) {
			ServletUtil.session(request).setAttribute("error", e.getMessage());
//			System.out.println(request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
//					+ commonServletHandler.nextURL(request, "/login"));
//			commonServletHandler.dispatchRequest(request, response, request.getScheme() + "://"
//					+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/");
			System.out.println(e);
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
		CustomerOperations customerOperation = new CustomerOperations();
		CustomerRecord customer = (CustomerRecord) ServletUtil.getUser(request);
		if (Objects.isNull(customer)) {
			response.sendRedirect(ServletUtil.nextURL(request, "/login"));
			return;
		}
		switch (path) {
		case "/customer/home":
			response.sendRedirect("account");
			break;

		case "/customer/account": {
			request.setAttribute("accounts", customerOperation.getAssociatedAccounts(customer.getUserId()));
			ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/customer/accounts.jsp");
		}
			break;

		case "/customer/account_details": {
			Long accountNumber = ServletUtil.getLongFromParameter(request, "account_number");
			Account account = customerOperation.getAccountDetails(accountNumber, customer.getUserId());
			Branch branch = customerOperation.getBranchDetailsOfAccount(account.getBranchId());
			request.setAttribute("account", account);
			request.setAttribute("branch", branch);
			ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/customer/account_details.jsp");
		}
			break;

		case "/customer/statement": {
			Map<Long, Account> accounts = (Map<Long, Account>) customerOperation
					.getAssociatedAccounts(customer.getUserId());
			request.setAttribute("accounts", accounts);
			ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/common/statement_select.jsp");
		}
			break;

		case "/customer/transfer": {
			Map<Long, Account> accounts = (Map<Long, Account>) customerOperation
					.getAssociatedAccounts(customer.getUserId());
			request.setAttribute("accounts", accounts);
			ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/customer/transfer.jsp");
		}
			break;

		case "/customer/change_password":
			ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/customer/change_password.jsp");
			break;

		case "/customer/profile":
			ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/customer/profile.jsp");
			break;

		case "/customer/profile_edit":
			ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/customer/profile_edit.jsp");
			break;

		default:
			ServletUtil.dispatchRequest(request, response, "/static/html/page_not_found.html");
			break;
		}
	}

	private void customerPostController(HttpServletRequest request, HttpServletResponse response, String path)
			throws AppException, ServletException, IOException {
		CustomerOperations customerOperation = new CustomerOperations();
		CustomerRecord customer = (CustomerRecord) ServletUtil.getUser(request);
		if (Objects.isNull(customer)) {
			response.sendRedirect(ServletUtil.nextURL(request, "/login"));
			return;
		}
		switch (path) {
		case "/customer/statement":
			commonServletHandler.statementPostRequest(request, response);
			break;

		case "/customer/authorization": {
			String operation = ServletUtil.getStringFromParameter(request, "operation");
			switch (operation) {
			case "authorize_transaction": {
				long viewer_account_number = ServletUtil.getLongFromParameter(request, "from-account");
				long transacted_account_number = ServletUtil.getLongFromParameter(request, "to-account");
				double amount = ServletUtil.getDoubleFromParameter(request, "amount");
				String transferWithinBankString = ServletUtil.getStringFromParameter(request,
						"transferWithinBank");
				boolean transferWithinBank = !Objects.isNull(transferWithinBankString);
				String ifsc = ServletUtil.getStringFromParameter(request, "ifsc");
				String remarks = ServletUtil.getStringFromParameter(request, "remarks");

				Transaction transaction = new Transaction();
				transaction.setViewerAccountNumber(viewer_account_number);
				transaction.setTransactedAccountNumber(transacted_account_number);
				transaction.setTransactedAmount(amount);
				transaction.setRemarks(remarks);
				transaction.setUserId(customer.getUserId());

				ServletUtil.session(request).setAttribute("transaction", transaction);
				ServletUtil.session(request).setAttribute("transferWithinBank", transferWithinBank);
				RequestDispatcher dispatcher = request
						.getRequestDispatcher("/WEB-INF/jsp/customer/authorization.jsp?redirect=process_transaction");
				dispatcher.forward(request, response);
			}
				break;

			case "process_transaction": {
				String pin = ServletUtil.getStringFromParameter(request, "pin");
				Transaction transaction = (Transaction) ServletUtil.session(request)
						.getAttribute("transaction");
				ServletUtil.session(request).removeAttribute("transaction");
				boolean transferWithinBank = (boolean) ServletUtil.session(request)
						.getAttribute("transferWithinBank");
				ServletUtil.session(request).removeAttribute("transferWithinBank");

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
				String oldAddress = (String) ServletUtil.getStringFromParameter(request, "old_address");
				String newAddress = (String) ServletUtil.getStringFromParameter(request, "new_address");
				String oldEmail = (String) ServletUtil.getStringFromParameter(request, "old_email");
				String newEmail = (String) ServletUtil.getStringFromParameter(request, "new_email");
				boolean addressChangeNeeded = !oldAddress.equals(newAddress);
				boolean emailChangeNeeded = !oldEmail.equals(newEmail);
				String url = "authorization.jsp?redirect=process_profile_update";
				if (!addressChangeNeeded && !emailChangeNeeded) {
					response.sendRedirect(ServletUtil.nextURL(request, "/customer/profile"));
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
				String pin = (String) ServletUtil.getStringFromParameter(request, "pin");
				try {
					List<ModifiableField> fields = (List) ServletUtil.session(request).getAttribute("fields");
					int customerId = customer.getUserId();
					for (ModifiableField field : fields) {
						Object value = ServletUtil.session(request)
								.getAttribute(field.toString().toLowerCase());
						customerOperation.updateUserDetails(customerId, field, value, pin);
					}
					CustomerRecord user = customerOperation.getCustomerRecord(customerId);
					ServletUtil.session(request).setAttribute("user", user);
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
				ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/customer/transaction_status.jsp");
			}
				break;

			default:
				ServletUtil.dispatchRequest(request, response, "/static/html/page_not_found.html");
				break;
			}
		}
			break;

		default:
			ServletUtil.dispatchRequest(request, response, "/static/html/page_not_found.html");
			break;
		}
	}

	private void employeeGetController(HttpServletRequest request, HttpServletResponse response, String path)
			throws IOException, AppException, ServletException {
		EmployeeOperations employeeOperation = new EmployeeOperations();
		EmployeeRecord employee = (EmployeeRecord) ServletUtil.getUser(request);
		if (Objects.isNull(employee)) {
			response.sendRedirect(ServletUtil.nextURL(request, "/login"));
			return;
		}
		switch (path) {
		case "home":
			response.sendRedirect("branch_accounts");
			break;

		case "branch_accounts": {
			int pageCount = employeeOperation.getBranchAccountsPageCount(employee.getBranchId());
			request.setAttribute("accounts", employeeOperation.getListOfAccountsInBranch(employee.getUserId(), 1));
			request.setAttribute("currentPage", 1);
			request.setAttribute("pageCount", pageCount);
			request.setAttribute("branch", employeeOperation.getBrachDetails(employee.getBranchId()));
			ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/employee/branch_accounts.jsp");
		}
			break;

		case "account_details": {
			try {
				Long accountNumber = ServletUtil.getLongFromParameter(request, "account_number");
				Account account = employeeOperation.getAccountDetails(accountNumber);
				CustomerRecord customer = employeeOperation.getCustomerRecord(account.getUserId());
				request.setAttribute("account", account);
				request.setAttribute("customer", customer);
				ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/employee/account_details.jsp");
			} catch (AppException e) {
				ServletUtil.session(request).setAttribute("error", e.getMessage());
				ServletUtil.dispatchRequest(request, response,
						employee.getType() == UserType.ADMIN ? "accounts" : "branch_accounts");
			}
		}
			break;

		case "account_details_edit": {
			Long accountNumber = ServletUtil.getLongFromParameter(request, "account_number");
			Account account = employeeOperation.getAccountDetails(accountNumber);
			CustomerRecord customer = employeeOperation.getCustomerRecord(account.getUserId());
			request.setAttribute("account", account);
			request.setAttribute("customer", customer);
			ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/employee/account_details_edit.jsp");
		}
			break;

		case "open_account":
			ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/employee/open_account.jsp");

			break;

		case "statement": {
			if (!Objects.isNull(request.getParameter("accountNumber"))) {
				long accountNumber = ServletUtil.getLongFromParameter(request, "accountNumber");
				request.setAttribute("accountNumber", accountNumber);
			}
			ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/common/statement_select.jsp");
		}
			break;

		case "transaction":
			ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/employee/transaction.jsp");
			break;

		case "change_password":
			ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/employee/change_password.jsp");
			break;

		case "profile":
			ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/employee/profile.jsp");
			break;

		case "search":
			ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/employee/search.jsp");
			break;

		default:
			ServletUtil.dispatchRequest(request, response, "/static/html/page_not_found.html");
			break;
		}
	}

	private void employeePostController(HttpServletRequest request, HttpServletResponse response, String path)
			throws AppException, ServletException, IOException {
		EmployeeOperations employeeOperation = new EmployeeOperations();
		EmployeeRecord employee = (EmployeeRecord) ServletUtil.getUser(request);
		if (Objects.isNull(employee)) {
			response.sendRedirect(ServletUtil.nextURL(request, "/login"));
			return;
		}
		switch (path) {
		case "branch_accounts": {
			Map<String, String[]> parameters = request.getParameterMap();
			if (parameters.containsKey("pageCount") && parameters.containsKey("currentPage")) {
				int pageCount = ServletUtil.getIntFromParameter(request, "pageCount");
				int currentPage = ServletUtil.getIntFromParameter(request, "currentPage");
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
			ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/employee/branch_accounts.jsp");
		}
			break;

		case "statement": {
			commonServletHandler.statementPostRequest(request, response);
		}
			break;

		case "search": {
			String searchBy = ServletUtil.getStringFromParameter(request, "search_by");
			try {
				if (searchBy.equals("customerId")) {
					int userId = ServletUtil.getIntFromParameter(request, "id");
					request.setAttribute("customer", (CustomerRecord) employeeOperation.getCustomerRecord(userId));
					request.setAttribute("accounts", employeeOperation.getAssociatedAccountsOfCustomer(userId));
					ServletUtil.dispatchRequest(request, response,
							"/WEB-INF/jsp/employee/search_customer.jsp");
				} else if (searchBy.equals("accountNumber")) {
					long accountNumber = ServletUtil.getLongFromParameter(request, "id");
					Account account = employeeOperation.getAccountDetails(accountNumber);
					CustomerRecord customer = employeeOperation.getCustomerRecord(account.getUserId());
					request.setAttribute("account", account);
					request.setAttribute("customer", customer);
					ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/employee/search_account.jsp");
				}
			} catch (AppException e) {
				ServletUtil.session(request).setAttribute("error", e.getMessage());
				ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/employee/search.jsp");
			}
		}
			break;

		case "authorization": {
			String operation = ServletUtil.getStringFromParameter(request, "operation");
			switch (operation) {
			case "authorize_transaction": {
				long accountNumber = ServletUtil.getLongFromParameter(request, "accountNumber");
				double amount = ServletUtil.getDoubleFromParameter(request, "amount");
				TransactionType type = TransactionType
						.valueOf(ServletUtil.getStringFromParameter(request, "type"));
				ServletUtil.session(request).setAttribute("accountNumber", accountNumber);
				ServletUtil.session(request).setAttribute("amount", amount);
				ServletUtil.session(request).setAttribute("type", type);
				ServletUtil.dispatchRequest(request, response,
						"/WEB-INF/jsp/customer/authorization.jsp?redirect=process_transaction");
			}
				break;

			case "process_transaction": {
				String pin = ServletUtil.getStringFromParameter(request, "pin");
				long accountNumber = (long) ServletUtil.session(request).getAttribute("accountNumber");
				double amount = (double) ServletUtil.session(request).getAttribute("amount");
				TransactionType type = (TransactionType) ServletUtil.session(request).getAttribute("type");

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
				AccountType accountType = AccountType
						.valueOf(ServletUtil.getStringFromParameter(request, "type"));
				double amount = ServletUtil.getDoubleFromParameter(request, "amount");
				String customerType = ServletUtil.getStringFromParameter(request, "customer");
				try {
					if (customerType.equals("new")) {
						CustomerRecord newCustomer = new CustomerRecord();
						newCustomer.setFirstName(ServletUtil.getStringFromParameter(request, "firstName"));
						newCustomer.setLastName(ServletUtil.getStringFromParameter(request, "lastName"));
						newCustomer.setDateOfBirth(ConvertorUtil.dateStringToMillis(
								ServletUtil.getStringFromParameter(request, "dateOfBirth")));
						newCustomer.setGender(ServletUtil.getIntFromParameter(request, "gender"));
						newCustomer.setAddress(ServletUtil.getStringFromParameter(request, "address"));
						newCustomer.setPhone(ServletUtil.getLongFromParameter(request, "mobile"));
						newCustomer.setEmail(ServletUtil.getStringFromParameter(request, "email"));
						newCustomer.setAadhaarNumber(ServletUtil.getLongFromParameter(request, "aadhar"));
						newCustomer.setPanNumber(ServletUtil.getStringFromParameter(request, "pan"));
						ServletUtil.session(request).setAttribute("newCustomer", newCustomer);
					} else if (customerType.equals("existing")) {
						int customerId = ServletUtil.getIntFromParameter(request, "userId");
						employeeOperation.getCustomerRecord(customerId);
						ServletUtil.session(request).setAttribute("customerId", customerId);
					}
					ServletUtil.session(request).setAttribute("accountType", accountType);
					ServletUtil.session(request).setAttribute("amount", amount);
					ServletUtil.session(request).setAttribute("customerType", customerType);
					ServletUtil.dispatchRequest(request, response,
							"/WEB-INF/jsp/customer/authorization.jsp?redirect=process_open_account");
				} catch (AppException e) {
					ServletUtil.session(request).setAttribute("error", e.getMessage());
					ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/employee/open_account.jsp");
				}
			}
				break;

			case "process_open_account": {
				String pin = ServletUtil.getStringFromParameter(request, "pin");
				AccountType accountType = (AccountType) ServletUtil.session(request)
						.getAttribute("accountType");
				double amount = (double) ServletUtil.session(request).getAttribute("amount");
				String customerType = (String) ServletUtil.session(request).getAttribute("customerType");
				try {
					if (customerType.equals("new")) {
						CustomerRecord newCustomer = (CustomerRecord) ServletUtil.session(request)
								.getAttribute("newCustomer");
						Account newAccount = employeeOperation.createNewCustomerAndAccount(newCustomer, accountType,
								amount, employee.getUserId(), pin);
						request.setAttribute("message", "New customer and account has been created\nCustomer ID : "
								+ newCustomer.getUserId() + "\nAccount Number : " + newAccount.getAccountNumber());
					} else if (customerType.equals("existing")) {
						int customerId = (int) ServletUtil.session(request).getAttribute("customerId");
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
				ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/customer/transaction_status.jsp");
			}
				break;
			case "authorize_change_password":
				commonServletHandler.passwordChangeAuthorizationPostRequest(request, response);
				break;

			case "process_change_password":
				commonServletHandler.passwordChangeProcessPostRequest(request, response);
				break;

			case "authorize_close_account": {
				long accountNumber = ServletUtil.getLongFromParameter(request, "accountNumber");
				try {
					employeeOperation.getAccountDetails(accountNumber);
					ServletUtil.session(request).setAttribute("accountNumber", accountNumber);
					ServletUtil.dispatchRequest(request, response,
							"/WEB-INF/jsp/common/authorization.jsp?redirect=process_close_account");
				} catch (AppException e) {
					request.setAttribute("status", false);
					request.setAttribute("message", e.getMessage());
					request.setAttribute("operation", "close_account");
					request.setAttribute("redirect", "branch_accounts");
					ServletUtil.dispatchRequest(request, response,
							"/WEB-INF/jsp/common/transaction_status.jsp");
				}
			}
				break;

			case "process_close_account": {
				String pin = ServletUtil.getStringFromParameter(request, "pin");
				long accountNumber = (long) ServletUtil.session(request).getAttribute("accountNumber");
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
				ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/customer/transaction_status.jsp");
			}
				break;
			default:
				ServletUtil.dispatchRequest(request, response, "/static/html/page_not_found.html");
				break;
			}
		}
			break;
		default:
			ServletUtil.dispatchRequest(request, response, "/static/html/page_not_found.html");
			break;
		}
	}

	private void adminGetController(HttpServletRequest request, HttpServletResponse response, String path)
			throws IOException, AppException, ServletException {
		AdminOperations adminOperations = new AdminOperations();
		EmployeeRecord admin = (EmployeeRecord) ServletUtil.getUser(request);
		if (Objects.isNull(admin) || admin.getType() != UserType.ADMIN) {
			response.sendRedirect(ServletUtil.nextURL(request, "/login"));
			return;
		}
		switch (path) {
		case "home":
			response.sendRedirect("employees");
			break;

		case "accounts": {
			int pageCount = adminOperations.getPageCountOfAccountsInBank();
			request.setAttribute("accounts", adminOperations.viewAccountsInBank(1));
			request.setAttribute("currentPage", 1);
			request.setAttribute("pageCount", pageCount);
			ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/admin/accounts.jsp");
		}
			break;

		case "employees": {
			int pageCount = adminOperations.getPageCountOfEmployees();
			request.setAttribute("employees", adminOperations.getEmployees(1));
			request.setAttribute("currentPage", 1);
			request.setAttribute("pageCount", pageCount);
			request.setAttribute("branch", adminOperations.getBranch(admin.getBranchId()));
			ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/admin/employees.jsp");
		}
			break;

		case "branches": {
			int pageCount = adminOperations.getPageCountOfBranches();
			request.setAttribute("branches", adminOperations.viewBrachesInBank(1));
			request.setAttribute("currentPage", 1);
			request.setAttribute("pageCount", pageCount);
			ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/admin/branches.jsp");
		}
			break;

		case "add_employee":
			ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/admin/add_employee.jsp");
			break;

		case "add_branch":
			ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/admin/add_branch.jsp");
			break;

		}

	}

	private void adminPostController(HttpServletRequest request, HttpServletResponse response, String path)
			throws AppException, IOException, ServletException {
		AdminOperations adminOperations = new AdminOperations();
		EmployeeRecord admin = (EmployeeRecord) ServletUtil.getUser(request);
		if (Objects.isNull(admin) || admin.getType() != UserType.ADMIN) {
			response.sendRedirect(ServletUtil.nextURL(request, "/login"));
			return;
		}
		switch (path) {
		case "accounts": {
			Map<String, String[]> parameters = request.getParameterMap();
			if (parameters.containsKey("pageCount") && parameters.containsKey("currentPage")) {
				int pageCount = ServletUtil.getIntFromParameter(request, "pageCount");
				int currentPage = ServletUtil.getIntFromParameter(request, "currentPage");
				request.setAttribute("accounts", adminOperations.viewAccountsInBank(currentPage));
				request.setAttribute("currentPage", currentPage);
				request.setAttribute("pageCount", pageCount);
			} else {
				int pageCount = adminOperations.getPageCountOfAccountsInBank();
				request.setAttribute("accounts", adminOperations.viewAccountsInBank(1));
				request.setAttribute("currentPage", 1);
				request.setAttribute("pageCount", pageCount);
			}
			ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/admin/accounts.jsp");
		}
			break;

		case "employees": {
			Map<String, String[]> parameters = request.getParameterMap();
			if (parameters.containsKey("pageCount") && parameters.containsKey("currentPage")) {
				int pageCount = ServletUtil.getIntFromParameter(request, "pageCount");
				int currentPage = ServletUtil.getIntFromParameter(request, "currentPage");
				request.setAttribute("employees", adminOperations.getEmployees(currentPage));
				request.setAttribute("currentPage", currentPage);
				request.setAttribute("pageCount", pageCount);
			} else {
				int pageCount = adminOperations.getPageCountOfEmployees();
				request.setAttribute("employees", adminOperations.getEmployees(1));
				request.setAttribute("currentPage", 1);
				request.setAttribute("pageCount", pageCount);
			}
			request.setAttribute("branch", adminOperations.getBranch(admin.getBranchId()));
			ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/admin/employees.jsp");
		}
			break;

		case "employee_details": {
			int employeeId = ServletUtil.getIntFromParameter(request, "id");
			try {
				request.setAttribute("employee", adminOperations.getEmployeeDetails(employeeId));
				ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/admin/employee_details.jsp");
			} catch (AppException e) {
				ServletUtil.session(request).setAttribute("error", e.getMessage());
				ServletUtil.dispatchRequest(request, response, "employees");
			}
		}
			break;

		case "branches": {
			Map<String, String[]> parameters = request.getParameterMap();
			if (parameters.containsKey("pageCount") && parameters.containsKey("currentPage")) {
				int pageCount = ServletUtil.getIntFromParameter(request, "pageCount");
				int currentPage = ServletUtil.getIntFromParameter(request, "currentPage");
				request.setAttribute("branches", adminOperations.viewBrachesInBank(currentPage));
				request.setAttribute("currentPage", currentPage);
				request.setAttribute("pageCount", pageCount);
			} else {
				int pageCount = adminOperations.getPageCountOfEmployees();
				request.setAttribute("branches", adminOperations.viewBrachesInBank(1));
				request.setAttribute("currentPage", 1);
				request.setAttribute("pageCount", pageCount);
			}
			request.setAttribute("branch", adminOperations.getBranch(admin.getBranchId()));
			ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/admin/employees.jsp");
		}
			break;

		case "search": {
			String searchBy = ServletUtil.getStringFromParameter(request, "search_by");
			try {
				if (searchBy.equals("employeeId")) {
					int userId = ServletUtil.getIntFromParameter(request, "id");
					request.setAttribute("employee", (EmployeeRecord) adminOperations.getEmployeeDetails(userId));
					ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/admin/employee_details.jsp");
				} else if (searchBy.equals("branchId")) {
					int branchId = ServletUtil.getIntFromParameter(request, "id");
					request.setAttribute("branch", adminOperations.getBranch(branchId));
					ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/admin/branch_details.jsp");
				}
			} catch (AppException e) {
				ServletUtil.session(request).setAttribute("error", e.getMessage());
				ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/employee/search.jsp");
			}
		}
			break;

		case "authorization": {
			String operation = ServletUtil.getStringFromParameter(request, "operation");
			switch (operation) {
			case "authorize_add_employee": {
				try {

					EmployeeRecord employee = new EmployeeRecord();
					employee.setFirstName(ServletUtil.getStringFromParameter(request, "firstName"));
					employee.setLastName(ServletUtil.getStringFromParameter(request, "lastName"));
					employee.setDateOfBirth(ConvertorUtil
							.dateStringToMillis(ServletUtil.getStringFromParameter(request, "dateOfBirth")));
					employee.setGender(ServletUtil.getIntFromParameter(request, "gender"));
					employee.setAddress(ServletUtil.getStringFromParameter(request, "address"));
					employee.setPhone(ServletUtil.getLongFromParameter(request, "mobile"));
					employee.setEmail(ServletUtil.getStringFromParameter(request, "email"));
					employee.setType(ServletUtil.getIntFromParameter(request, "role"));
					employee.setBranchId(ServletUtil.getIntFromParameter(request, "branchId"));

					ServletUtil.session(request).setAttribute("employee", employee);
					ServletUtil.dispatchRequest(request, response,
							"/WEB-INF/jsp/common/authorization.jsp?redirect=process_add_employee");
				} catch (AppException e) {
					ServletUtil.session(request).setAttribute("error", e.getMessage());
					ServletUtil.dispatchRequest(request, response, "employees");
				}
			}
				break;

			case "process_add_employee": {
				String pin = ServletUtil.getStringFromParameter(request, "pin");
				try {
					EmployeeRecord employee = (EmployeeRecord) ServletUtil.session(request)
							.getAttribute("employee");
					ServletUtil.session(request).removeAttribute("employee");
					adminOperations.createEmployee(employee, admin.getUserId(), pin);
					request.setAttribute("message",
							"New employee has been created<br>Employee ID : " + employee.getUserId());
					request.setAttribute("status", true);
				} catch (AppException e) {
					request.setAttribute("status", false);
					request.setAttribute("message", e.getMessage());
				}
				request.setAttribute("redirect", "employees");
				request.setAttribute("operation", "add_employee");
				ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/common/transaction_status.jsp");
			}
				break;

			case "authorize_add_branch": {
				try {
					Branch branch = new Branch();
					branch.setAddress(ServletUtil.getStringFromParameter(request, "address"));
					branch.setPhone(ServletUtil.getLongFromParameter(request, "phone"));
					branch.setEmail(ServletUtil.getStringFromParameter(request, "email") + "@cskbank.in");

					ServletUtil.session(request).setAttribute("branch", branch);
					ServletUtil.dispatchRequest(request, response,
							"/WEB-INF/jsp/common/authorization.jsp?redirect=process_add_branch");
				} catch (AppException e) {
					ServletUtil.session(request).setAttribute("error", e.getMessage());
					ServletUtil.dispatchRequest(request, response, "branches");
				}
			}
				break;

			case "process_add_branch": {
				String pin = ServletUtil.getStringFromParameter(request, "pin");
				try {
					Branch branch = (Branch) ServletUtil.session(request).getAttribute("branch");
					ServletUtil.session(request).removeAttribute("branch");
					branch = adminOperations.createBranch(branch);
					request.setAttribute("message",
							"New Branch Record has been created<br>Branch ID : " + branch.getBranchId());
					request.setAttribute("status", true);
				} catch (AppException e) {
					request.setAttribute("status", false);
					request.setAttribute("message", e.getMessage());
				}
				request.setAttribute("redirect", "branches");
				request.setAttribute("operation", "add_branch");
				ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/common/transaction_status.jsp");
			}
				break;

			default:
				break;
			}
		}
			break;
		}
	}

}
