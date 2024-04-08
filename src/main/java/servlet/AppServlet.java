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
					commonServletHandler.dispatchRequest(request, response, "/static/html/page_not_found.html");
					break;
				}
			}
		} catch (

		AppException e) {
			commonServletHandler.session(request).setAttribute("error", e.getMessage());
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
					commonServletHandler.dispatchRequest(request, response, "/WEB-INF/jsp/login.jsp");
				}
					break;

				default:
					commonServletHandler.dispatchRequest(request, response, "/static/html/page_not_found.html");
					break;

				}
			}
		} catch (AppException e) {
			commonServletHandler.session(request).setAttribute("error", e.getMessage());
			response.sendRedirect("home");
		}
	}

	private void customerGetController(HttpServletRequest request, HttpServletResponse response, String path)
			throws AppException, ServletException, IOException {
		CustomerRecord customer = (CustomerRecord) commonServletHandler.getUser(request);
		if (Objects.isNull(customer)) {
			response.sendRedirect(commonServletHandler.nextURL(request, "/login"));
			return;
		}
		switch (path) {
		case "/customer/home":
		case "/customer/account": {

			request.setAttribute("accounts", customerOperation.getAssociatedAccounts(customer.getUserId()));
			commonServletHandler.dispatchRequest(request, response, "/WEB-INF/jsp/customer/accounts.jsp");
		}
			break;

		case "/customer/account_details": {
			Long accountNumber = commonServletHandler.getLongFromParameter(request, "account_number");
			Account account = customerOperation.getAccountDetails(accountNumber, customer.getUserId());
			Branch branch = customerOperation.getBranchDetailsOfAccount(account.getBranchId());
			request.setAttribute("account", account);
			request.setAttribute("branch", branch);
			commonServletHandler.dispatchRequest(request, response, "/WEB-INF/jsp/customer/account_details.jsp");
		}
			break;

		case "/customer/statement": {
			Map<Long, Account> accounts = (Map<Long, Account>) customerOperation
					.getAssociatedAccounts(customer.getUserId());
			request.setAttribute("accounts", accounts);
			commonServletHandler.dispatchRequest(request, response, "/WEB-INF/jsp/common/statement_select.jsp");
		}
			break;

		case "/customer/transfer": {
			Map<Long, Account> accounts = (Map<Long, Account>) customerOperation
					.getAssociatedAccounts(customer.getUserId());
			request.setAttribute("accounts", accounts);
			commonServletHandler.dispatchRequest(request, response, "/WEB-INF/jsp/customer/transfer.jsp");
		}
			break;

		case "/customer/change_password": {
			commonServletHandler.dispatchRequest(request, response, "/WEB-INF/jsp/customer/change_password.jsp");
		}
			break;

		case "/customer/profile": {
			commonServletHandler.dispatchRequest(request, response, "/WEB-INF/jsp/customer/profile.jsp");
		}
			break;
		case "/customer/profile_edit": {
			commonServletHandler.dispatchRequest(request, response, "/WEB-INF/jsp/customer/profile_edit.jsp");
		}
			break;

		default:
			commonServletHandler.dispatchRequest(request, response, "/static/html/page_not_found.html");
			break;
		}
	}

	private void customerPostController(HttpServletRequest request, HttpServletResponse response, String path)
			throws AppException, ServletException, IOException {
		CustomerRecord customer = (CustomerRecord) commonServletHandler.getUser(request);
		if (Objects.isNull(customer)) {
			response.sendRedirect(commonServletHandler.nextURL(request, "/login"));
			return;
		}
		switch (path) {
		case "/customer/statement":
			commonServletHandler.statementPostRequest(request, response);
			break;

		case "/customer/authorization": {
			String operation = commonServletHandler.getStringFromParameter(request, "operation");
			switch (operation) {
			case "authorize_transaction": {
				long viewer_account_number = commonServletHandler.getLongFromParameter(request, "from-account");
				long transacted_account_number = commonServletHandler.getLongFromParameter(request, "to-account");
				double amount = commonServletHandler.getDoubleFromParameter(request, "amount");
				String transferWithinBankString = commonServletHandler.getStringFromParameter(request,
						"transferWithinBank");
				boolean transferWithinBank = !Objects.isNull(transferWithinBankString);
				String ifsc = commonServletHandler.getStringFromParameter(request, "ifsc");
				String remarks = commonServletHandler.getStringFromParameter(request, "remarks");

				Transaction transaction = new Transaction();
				transaction.setViewerAccountNumber(viewer_account_number);
				transaction.setTransactedAccountNumber(transacted_account_number);
				transaction.setTransactedAmount(amount);
				transaction.setRemarks(remarks);
				transaction.setUserId(customer.getUserId());

				commonServletHandler.session(request).setAttribute("transaction", transaction);
				commonServletHandler.session(request).setAttribute("transferWithinBank", transferWithinBank);
				RequestDispatcher dispatcher = request
						.getRequestDispatcher("/WEB-INF/jsp/customer/authorization.jsp?redirect=process_transaction");
				dispatcher.forward(request, response);
			}
				break;

			case "process_transaction": {
				String pin = commonServletHandler.getStringFromParameter(request, "pin");
				Transaction transaction = (Transaction) commonServletHandler.session(request)
						.getAttribute("transaction");
				commonServletHandler.session(request).removeAttribute("transaction");
				boolean transferWithinBank = (boolean) commonServletHandler.session(request)
						.getAttribute("transferWithinBank");
				commonServletHandler.session(request).removeAttribute("transferWithinBank");

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
				String oldAddress = (String) commonServletHandler.getStringFromParameter(request, "old_address");
				String newAddress = (String) commonServletHandler.getStringFromParameter(request, "new_address");
				String oldEmail = (String) commonServletHandler.getStringFromParameter(request, "old_email");
				String newEmail = (String) commonServletHandler.getStringFromParameter(request, "new_email");
				boolean addressChangeNeeded = !oldAddress.equals(newAddress);
				boolean emailChangeNeeded = !oldEmail.equals(newEmail);
				String url = "authorization.jsp?redirect=process_profile_update";
				if (!addressChangeNeeded && !emailChangeNeeded) {
					response.sendRedirect(commonServletHandler.nextURL(request, "/customer/profile"));
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
				String pin = (String) commonServletHandler.getStringFromParameter(request, "pin");
				try {
					List<ModifiableField> fields = (List) commonServletHandler.session(request).getAttribute("fields");
					int customerId = customer.getUserId();
					for (ModifiableField field : fields) {
						Object value = commonServletHandler.session(request)
								.getAttribute(field.toString().toLowerCase());
						customerOperation.updateUserDetails(customerId, field, value, pin);
					}
					CustomerRecord user = customerOperation.getCustomerRecord(customerId);
					System.out.println(user.getAddress());
					commonServletHandler.session(request).setAttribute("user", user);
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
				commonServletHandler.dispatchRequest(request, response, "/static/html/page_not_found.html");
				break;
			}
		}
			break;

		default:
			commonServletHandler.dispatchRequest(request, response, "/static/html/page_not_found.html");
			break;
		}
	}

	private void employeeGetController(HttpServletRequest request, HttpServletResponse response, String path)
			throws IOException, AppException, ServletException {
		EmployeeRecord employee = (EmployeeRecord) commonServletHandler.getUser(request);
		if (Objects.isNull(employee)) {
			response.sendRedirect(commonServletHandler.nextURL(request, "/login"));
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
			commonServletHandler.dispatchRequest(request, response, "/WEB-INF/jsp/employee/branch_accounts.jsp");
		}
			break;

		case "/employee/account_details": {
			Long accountNumber = commonServletHandler.getLongFromParameter(request, "account_number");
			Account account = employeeOperation.getAccountDetails(accountNumber);
			CustomerRecord customer = employeeOperation.getCustomerRecord(account.getUserId());
			request.setAttribute("account", account);
			request.setAttribute("customer", customer);
			commonServletHandler.dispatchRequest(request, response, "/WEB-INF/jsp/employee/account_details.jsp");
		}
			break;

		case "/employee/account_details_edit": {
			Long accountNumber = commonServletHandler.getLongFromParameter(request, "account_number");
			Account account = employeeOperation.getAccountDetails(accountNumber);
			CustomerRecord customer = employeeOperation.getCustomerRecord(account.getUserId());
			request.setAttribute("account", account);
			request.setAttribute("customer", customer);
			commonServletHandler.dispatchRequest(request, response, "/WEB-INF/jsp/employee/account_details_edit.jsp");
		}
			break;

		case "/employee/open_account": {
			commonServletHandler.dispatchRequest(request, response, "/WEB-INF/jsp/employee/open_account.jsp");
		}
			break;

		case "/employee/statement": {
			if (!Objects.isNull(request.getParameter("accountNumber"))) {
				long accountNumber = commonServletHandler.getLongFromParameter(request, "accountNumber");
				request.setAttribute("accountNumber", accountNumber);
			}
			commonServletHandler.dispatchRequest(request, response, "/WEB-INF/jsp/common/statement_select.jsp");
		}
			break;

		case "/employee/transaction": {
			commonServletHandler.dispatchRequest(request, response, "/WEB-INF/jsp/employee/transaction.jsp");
		}
			break;

		case "/employee/change_password": {
			commonServletHandler.dispatchRequest(request, response, "/WEB-INF/jsp/employee/change_password.jsp");
		}
			break;

		case "/employee/profile": {
			commonServletHandler.dispatchRequest(request, response, "/WEB-INF/jsp/employee/profile.jsp");
		}
			break;
		case "/employee/profile_edit": {
			commonServletHandler.dispatchRequest(request, response, "/WEB-INF/jsp/employee/profile_edit.jsp");
		}
			break;

		default:
			commonServletHandler.dispatchRequest(request, response, "/static/html/page_not_found.html");
			break;
		}
	}

	private void employeePostController(HttpServletRequest request, HttpServletResponse response, String path)
			throws AppException, ServletException, IOException {
		EmployeeRecord employee = (EmployeeRecord) commonServletHandler.getUser(request);
		if (Objects.isNull(employee)) {
			response.sendRedirect(commonServletHandler.nextURL(request, "/login"));
			return;
		}
		switch (path) {
		case "/employee/branch_accounts": {
			Map<String, String[]> parameters = request.getParameterMap();
			if (parameters.containsKey("pageCount") && parameters.containsKey("currentPage")) {
				int pageCount = commonServletHandler.getIntFromParameter(request, "pageCount");
				int currentPage = commonServletHandler.getIntFromParameter(request, "currentPage");
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
			commonServletHandler.dispatchRequest(request, response, "/WEB-INF/jsp/employee/branch_accounts.jsp");
		}
			break;

		case "/employee/statement": {
			commonServletHandler.statementPostRequest(request, response);
		}
			break;

		case "/employee/authorization": {
			String operation = commonServletHandler.getStringFromParameter(request, "operation");
			switch (operation) {
			case "authorize_transaction": {
				long accountNumber = commonServletHandler.getLongFromParameter(request, "accountNumber");
				double amount = commonServletHandler.getDoubleFromParameter(request, "amount");
				TransactionType type = TransactionType
						.valueOf(commonServletHandler.getStringFromParameter(request, "type"));
				commonServletHandler.session(request).setAttribute("accountNumber", accountNumber);
				commonServletHandler.session(request).setAttribute("amount", amount);
				commonServletHandler.session(request).setAttribute("type", type);
				commonServletHandler.dispatchRequest(request, response,
						"/WEB-INF/jsp/customer/authorization.jsp?redirect=process_transaction");
			}
				break;

			case "process_transaction": {
				String pin = commonServletHandler.getStringFromParameter(request, "pin");
				long accountNumber = (long) commonServletHandler.session(request).getAttribute("accountNumber");
				double amount = (double) commonServletHandler.session(request).getAttribute("amount");
				TransactionType type = (TransactionType) commonServletHandler.session(request).getAttribute("type");

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
						.valueOf(commonServletHandler.getStringFromParameter(request, "type"));
				double amount = commonServletHandler.getDoubleFromParameter(request, "amount");
				String customerType = commonServletHandler.getStringFromParameter(request, "customer");
				try {
					if (customerType.equals("new")) {
						CustomerRecord newCustomer = new CustomerRecord();
						newCustomer.setFirstName(commonServletHandler.getStringFromParameter(request, "firstName"));
						newCustomer.setLastName(commonServletHandler.getStringFromParameter(request, "lastName"));
						newCustomer.setDateOfBirth(ConvertorUtil.dateStringToMillis(
								commonServletHandler.getStringFromParameter(request, "dateOfBirth")));
						newCustomer.setGender(commonServletHandler.getIntFromParameter(request, "gender"));
						newCustomer.setAddress(commonServletHandler.getStringFromParameter(request, "address"));
						newCustomer.setPhone(commonServletHandler.getLongFromParameter(request, "mobile"));
						newCustomer.setEmail(commonServletHandler.getStringFromParameter(request, "email"));
						newCustomer.setAadhaarNumber(commonServletHandler.getLongFromParameter(request, "aadhar"));
						newCustomer.setPanNumber(commonServletHandler.getStringFromParameter(request, "pan"));
						commonServletHandler.session(request).setAttribute("newCustomer", newCustomer);
					} else if (customerType.equals("existing")) {
						int customerId = commonServletHandler.getIntFromParameter(request, "userId");
						employeeOperation.getCustomerRecord(customerId);
						commonServletHandler.session(request).setAttribute("customerId", customerId);
					}
					commonServletHandler.session(request).setAttribute("accountType", accountType);
					commonServletHandler.session(request).setAttribute("amount", amount);
					commonServletHandler.session(request).setAttribute("customerType", customerType);
					commonServletHandler.dispatchRequest(request, response,
							"/WEB-INF/jsp/customer/authorization.jsp?redirect=process_open_account");
				} catch (AppException e) {
					commonServletHandler.session(request).setAttribute("error", e.getMessage());
					commonServletHandler.dispatchRequest(request, response, "/WEB-INF/jsp/employee/open_account.jsp");
				}
			}
				break;

			case "process_open_account": {
				String pin = commonServletHandler.getStringFromParameter(request, "pin");
				AccountType accountType = (AccountType) commonServletHandler.session(request)
						.getAttribute("accountType");
				double amount = (double) commonServletHandler.session(request).getAttribute("amount");
				String customerType = (String) commonServletHandler.session(request).getAttribute("customerType");
				try {
					if (customerType.equals("new")) {
						CustomerRecord newCustomer = (CustomerRecord) commonServletHandler.session(request)
								.getAttribute("newCustomer");
						Account newAccount = employeeOperation.createNewCustomerAndAccount(newCustomer, accountType,
								amount, employee.getUserId(), pin);
						request.setAttribute("message", "New customer and account has been created\nCustomer ID : "
								+ newCustomer.getUserId() + "\nAccount Number : " + newAccount.getAccountNumber());
					} else if (customerType.equals("existing")) {
						int customerId = (int) commonServletHandler.session(request).getAttribute("customerId");
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
				commonServletHandler.dispatchRequest(request, response, "/WEB-INF/jsp/customer/transaction_status.jsp");
			}
				break;
			case "authorize_change_password":
				commonServletHandler.passwordChangeAuthorizationPostRequest(request, response);
				break;

			case "process_change_password":
				commonServletHandler.passwordChangeProcessPostRequest(request, response);
				break;

			case "authorize_close_account": {
				long accountNumber = commonServletHandler.getLongFromParameter(request, "accountNumber");
				try {
					employeeOperation.getAccountDetails(accountNumber);
					commonServletHandler.session(request).setAttribute("accountNumber", accountNumber);
					commonServletHandler.dispatchRequest(request, response,
							"/WEB-INF/jsp/common/authorization.jsp?redirect=process_close_account");
				} catch (AppException e) {
					request.setAttribute("status", false);
					request.setAttribute("message", e.getMessage());
					request.setAttribute("operation", "close_account");
					request.setAttribute("redirect", "branch_accounts");
					commonServletHandler.dispatchRequest(request, response,
							"/WEB-INF/jsp/common/transaction_status.jsp");
				}
			}
				break;

			case "process_close_account": {
				String pin = commonServletHandler.getStringFromParameter(request, "pin");
				long accountNumber = (long) commonServletHandler.session(request).getAttribute("accountNumber");
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
				commonServletHandler.dispatchRequest(request, response, "/WEB-INF/jsp/customer/transaction_status.jsp");
			}
				break;

			default:
				commonServletHandler.dispatchRequest(request, response, "/static/html/page_not_found.html");
				break;
			}
			break;
		}
		default:
			commonServletHandler.dispatchRequest(request, response, "/static/html/page_not_found.html");
			break;
		}
	}
}
