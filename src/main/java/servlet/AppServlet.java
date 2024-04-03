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
import utility.ConstantsUtil.Gender;
import utility.ConstantsUtil.ModifiableField;
import utility.ConstantsUtil.TransactionHistoryLimit;
import utility.ConstantsUtil.UserType;
import utility.ConvertorUtil;

public class AppServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private AppOperations appOperation;
	private CustomerOperations customerOperation;
	private EmployeeOperations employeeOperation;

	public AppServlet() throws AppException {
		appOperation = new AppOperations();
		customerOperation = new CustomerOperations();
		employeeOperation = new EmployeeOperations();
	}
//	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		try {
//
//			String path = request.getPathInfo();
//
//			AppOperations appOperation = new AppOperations();
//			CustomerOperations customerOperation = new CustomerOperations();
//
//			System.out.println(path);
//			System.out.println(path.equals("/login"));
//			if (path.equals("/login")) {
//				int userId = Integer.parseInt(request.getParameter("userId"));
//				String password = request.getParameter("password");
//				try {
//					UserRecord user = appOperation.getUser(userId, password);
//					HttpSession session = request.getSession(false);
//					session.setAttribute("user", user);
//					if (user.getType() == UserType.CUSTOMER) {
//						Map<Long, Account> accounts = customerOperation.getAssociatedAccounts(userId);
//						request.setAttribute("accounts", accounts);
//						RequestDispatcher dispatcher = request.getRequestDispatcher("/app/account");
//						dispatcher.forward(request, response);
//					} else {
//						request.setAttribute("alert", "Not registered as a Customer");
//						RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
//						dispatcher.forward(request, response);
//					}
//				} catch (AppException e) {
//					e.printStackTrace();
//					request.setAttribute("alert", e.getMessage());
//					RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
//					dispatcher.forward(request, response);
//				}
//			}
//
//			else {
//				String route = request.getParameter("route");
//				if (Objects.isNull(getUser(request))) {
//					RequestDispatcher dispatch = request.getRequestDispatcher("index.jsp");
//					dispatch.forward(request, response);
//				} else {
//					switch (route) {
//
//					case "authorization_request": {
//						long viewer_account_number = Long.parseLong(request.getParameter("from-account"));
//						long transacted_account_number = Long.parseLong(request.getParameter("to-account"));
//						double amount = Double.parseDouble(request.getParameter("amount"));
//						String transferWithinBankString = request.getParameter("transferWithinBank");
//						boolean trasferWithinBank = !Objects.isNull(transferWithinBankString);
//						String remarks = request.getParameter("remarks");
//
//						Transaction transaction = new Transaction();
//						transaction.setViewerAccountNumber(viewer_account_number);
//						transaction.setTransactedAccountNumber(transacted_account_number);
//						transaction.setTransactedAmount(amount);
//						transaction.setRemarks(remarks);
//
//						request.getSession(false).setAttribute("transaction", transaction);
//						request.getSession(false).setAttribute("transferWithinBank", trasferWithinBank);
//						RequestDispatcher dispatcher = request
//								.getRequestDispatcher("/WEB-INF/jsp/customer/authorization.jsp?redirect=authorize");
//						dispatcher.forward(request, response);
//					}
//						break;
//
//					case "authorize": {
//
//						UserRecord user = getUser(request);
//						String pin = request.getParameter("pin");
//						HttpSession session = request.getSession(false);
//						Transaction transaction = (Transaction) session.getAttribute("transaction");
//						session.removeAttribute("transaction");
//						transaction.setUserId(user.getUserId());
//						boolean transferWithinBank = (boolean) session.getAttribute("transferWithinBank");
//						session.removeAttribute("transferWithinBank");
//
//						try {
//							long transactionId = customerOperation.tranferMoney(transaction, transferWithinBank, pin);
//							request.setAttribute("status", true);
//							request.setAttribute("operation", "transaction");
//							request.setAttribute("message",
//									"Your Transaction has been completed!\n Tranaction ID : " + transactionId);
//							request.setAttribute("redirect", "account");
//						} catch (AppException e) {
//							e.printStackTrace();
//							request.setAttribute("status", false);
//							request.setAttribute("operation", "transaction");
//							request.setAttribute("message", e.getMessage());
//							request.setAttribute("redirect", "transfer");
//						}
//						RequestDispatcher dispatcher = request
//								.getRequestDispatcher("/WEB-INF/jsp/customer/transaction_status.jsp");
//						dispatcher.forward(request, response);
//
//					}
//						break;
//
//					case "change_password_authorization_request": {
//						String oldPassword = (String) request.getParameter("oldPassword");
//						String newPassword = (String) request.getParameter("newPassword");
//
//						try {
//							appOperation.getUser(getUser(request).getUserId(), oldPassword);
//							request.getSession(false).setAttribute("oldPassword", oldPassword);
//							request.getSession(false).setAttribute("newPassword", newPassword);
//							RequestDispatcher dispatcher = request.getRequestDispatcher(
//									"/WEB-INF/jsp/customer/authorization.jsp?redirect=authorize_change_password");
//							dispatcher.forward(request, response);
//						} catch (AppException e) {
//							request.setAttribute("status", false);
//							request.setAttribute("operation", "password_change");
//							request.setAttribute("message", e.getMessage());
//							request.setAttribute("redirect", "change_password");
//							RequestDispatcher dispatcher = request
//									.getRequestDispatcher("/WEB-INF/jsp/customer/transaction_status.jsp");
//							dispatcher.forward(request, response);
//						}
//					}
//						break;
//
//					case "authorize_change_password": {
//						String oldPassword = (String) request.getSession(false).getAttribute("oldPassword");
//						String newPassword = (String) request.getSession(false).getAttribute("newPassword");
//						String pin = (String) request.getParameter("pin");
//
//						try {
//							customerOperation.updatePassword(getUser(request).getUserId(), oldPassword, newPassword,
//									pin);
//							request.setAttribute("status", true);
//							request.setAttribute("operation", "password_change");
//							request.setAttribute("message", "New password has been updated");
//							request.setAttribute("redirect", "logout");
//						} catch (AppException e) {
//							request.setAttribute("status", false);
//							request.setAttribute("operation", "password_change");
//							request.setAttribute("message", e.getMessage());
//							request.setAttribute("redirect", "change_password");
//						}
//						RequestDispatcher dispatcher = request
//								.getRequestDispatcher("/WEB-INF/jsp/customer/transaction_status.jsp");
//						dispatcher.forward(request, response);
//					}
//						break;
//
//					case "customer_profile_update_request": {
//						String oldAddress = (String) request.getParameter("old_address");
//						String newAddress = (String) request.getParameter("new_address");
//						String oldEmail = (String) request.getParameter("old_email");
//						String newEmail = (String) request.getParameter("new_email");
//						boolean addressChangeNeeded = !oldAddress.equals(newAddress);
//						boolean emailChangeNeeded = !oldEmail.equals(newEmail);
//						String url = "authorization.jsp?redirect=profile_update_authorization";
//						if (!addressChangeNeeded && !emailChangeNeeded) {
//							url = "profile.jsp";
//						} else {
//							List<ModifiableField> fields = new ArrayList<>();
//							if (addressChangeNeeded) {
//								request.getSession(false).setAttribute("address", newAddress);
//								fields.add(ModifiableField.ADDRESS);
//							}
//							if (emailChangeNeeded) {
//								request.getSession(false).setAttribute("email", newEmail);
//								fields.add(ModifiableField.EMAIL);
//							}
//							request.getSession(false).setAttribute("fields", fields);
//						}
//						RequestDispatcher dispatch = request.getRequestDispatcher("/WEB-INF/jsp/customer/" + url);
//						dispatch.forward(request, response);
//					}
//						break;
//
//					case "profile_update_authorization": {
//						String pin = (String) request.getParameter("pin");
//						HttpSession session = request.getSession(false);
//						try {
//							List<ModifiableField> fields = (List<ModifiableField>) session.getAttribute("fields");
//							int customerId = getUser(request).getUserId();
//							for (ModifiableField field : fields) {
//								Object value = session.getAttribute(field.toString().toLowerCase());
//								customerOperation.updateUserDetails(customerId, field, value, pin);
//							}
//							CustomerRecord user = customerOperation.getCustomerRecord(customerId);
//							System.out.println(user.getAddress());
//							session.setAttribute("user", user);
//
//							request.setAttribute("status", true);
//							request.setAttribute("operation", "profile_update");
//							request.setAttribute("message",
//									"The profile details have been updated\nThe changes will be updated shortly");
//							request.setAttribute("redirect", "customer_profile");
//						} catch (AppException e) {
//							e.printStackTrace();
//							request.setAttribute("status", true);
//							request.setAttribute("operation", "profile_update");
//							request.setAttribute("message", "An error occured. " + e.getMessage());
//							request.setAttribute("redirect", "customer_profile");
//						}
//						RequestDispatcher dispatcher = request
//								.getRequestDispatcher("/WEB-INF/jsp/customer/transaction_status.jsp");
//						dispatcher.forward(request, response);
//					}
//						break;
//
//					default: {
//						RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
//						dispatcher.forward(request, response);
//					}
//						break;
//					}
//				}
//			}
//		} catch (Exception e) {
//			throw new ServletException(e);
//
//		}
//	}

//	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		try {
//			if (Objects.isNull(getUser(request))) {
//				RequestDispatcher dispatch = request.getRequestDispatcher("index.jsp");
//				dispatch.forward(request, response);
//			}
//
//			else {
//				AppOperations appOperation = new AppOperations();
//				CustomerOperations customerOperation = new CustomerOperations();
//				String route = request.getPathInfo();
//
//				switch (route) {
//
//				case "/account": {
//					UserRecord user = (UserRecord) request.getSession(false).getAttribute("user");
//					if (user.getType() == UserType.CUSTOMER) {
//						Map<Long, Account> accounts = customerOperation.getAssociatedAccounts(user.getUserId());
//						request.setAttribute("accounts", accounts);
//						RequestDispatcher dispatcher = request
//								.getRequestDispatcher("/WEB-INF/jsp/customer/accounts.jsp");
//						dispatcher.forward(request, response);
//					}
//				}
//					break;
//
//				case "account_details": {
//					UserRecord user = (UserRecord) request.getSession(false).getAttribute("user");
//					Long accountNumber = Long.parseLong(request.getParameter("account_number"));
//					Account account = customerOperation.getAccountDetails(accountNumber, user.getUserId());
//					System.out.println(account.getLastTransactedAt());
//					List<Transaction> transactions = customerOperation.getTransactionsOfAccount(accountNumber, 1,
//							TransactionHistoryLimit.RECENT);
//					Branch branch = customerOperation.getBranchDetailsOfAccount(account.getBranchId());
//					request.setAttribute("account", account);
//					request.setAttribute("transactions", transactions);
//					request.setAttribute("branch", branch);
//					RequestDispatcher dispatcher = request
//							.getRequestDispatcher("/WEB-INF/jsp/customer/account_details.jsp");
//					dispatcher.forward(request, response);
//				}
//					break;
//
//				case "transfer": {
//					UserRecord user = (UserRecord) request.getSession(false).getAttribute("user");
//					System.out.println(user.getUserId());
//					Map<Long, Account> accounts = (Map<Long, Account>) customerOperation
//							.getAssociatedAccounts(user.getUserId());
//					request.setAttribute("accounts", accounts);
//					RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/customer/transfer.jsp");
//					dispatcher.forward(request, response);
//				}
//					break;
//
//				case "statement_select": {
//					UserRecord user = (UserRecord) request.getSession(false).getAttribute("user");
//					System.out.println(user.getUserId());
//					Map<Long, Account> accounts = (Map<Long, Account>) customerOperation
//							.getAssociatedAccounts(user.getUserId());
//					request.setAttribute("accounts", accounts);
//					RequestDispatcher dispatcher = request
//							.getRequestDispatcher("/WEB-INF/jsp/customer/statement_select.jsp");
//					dispatcher.forward(request, response);
//				}
//					break;
//
//				case "statement_view": {
//					long accountNumber = Long.parseLong(request.getParameter("account_number"));
//					TransactionHistoryLimit limit = TransactionHistoryLimit
//							.valueOf(request.getParameter("transaction_limit").toString());
//
//					List<Transaction> transactions = customerOperation.getTransactionsOfAccount(accountNumber, 1,
//							limit);
//					request.setAttribute("transactions", transactions);
//					RequestDispatcher dispatcher = request
//							.getRequestDispatcher("/WEB-INF/jsp/customer/statement_view.jsp");
//					dispatcher.forward(request, response);
//				}
//					break;
//
//				case "change_password": {
//					RequestDispatcher dispatcher = request
//							.getRequestDispatcher("/WEB-INF/jsp/customer/change_password.jsp");
//					dispatcher.forward(request, response);
//				}
//					break;
//
//				case "customer_profile": {
//					RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/customer/profile.jsp");
//					dispatcher.forward(request, response);
//				}
//					break;
//
//				case "customer_profile_edit": {
//					RequestDispatcher dispatcher = request
//							.getRequestDispatcher("/WEB-INF/jsp/customer/profile_edit.jsp");
//					dispatcher.forward(request, response);
//				}
//					break;
//
//				case "logout": {
//					request.getSession(false).invalidate();
//					RequestDispatcher dispatch = request.getRequestDispatcher("index.jsp");
//					dispatch.forward(request, response);
//					break;
//				}
//
//				default: {
//					RequestDispatcher dispatch = request.getRequestDispatcher("index.jsp");
//					dispatch.forward(request, response);
//				}
//					break;
//				}
//			}
//
//		} catch (Exception e) {
//			throw new ServletException(e.getMessage(), e);
//		}
//	}

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
					Map<String, String[]> parameters = request.getParameterMap();
					if (parameters.containsKey("userId") && parameters.containsKey("password")) {
						System.out.println(parameters.get("userId")[0]);
						System.out.println(parameters.get("password")[0]);
						int userId = Integer.parseInt(request.getParameter("userId"));
						String password = request.getParameter("password");
						try {
							UserRecord user = appOperation.getUser(userId, password);
							session(request).setAttribute("user", user);
							if (user.getType() == UserType.CUSTOMER) {
								Map<Long, Account> accounts = customerOperation.getAssociatedAccounts(userId);
								request.setAttribute("accounts", accounts);
								response.sendRedirect("customer/account");
							} else if (user.getType() == UserType.EMPLOYEE) {
								Map<Long, Account> accounts = employeeOperation.getListOfAccountsInBranch(userId, 1);
								request.setAttribute("accounts", accounts);
								response.sendRedirect("employee/branch_accounts");
							} else if (user.getType() == UserType.ADMIN) {
								Map<Long, Account> accounts = employeeOperation.getListOfAccountsInBranch(userId, 1);
								request.setAttribute("accounts", accounts);
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
					break;
				}
			}
		} catch (

		AppException e) {
			session(request).invalidate();
			request.getSession();
			request.setAttribute("alertMessage", e.getMessage());
			dispatchRequest(request, response, "/");
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
				}
			}
		} catch (AppException e) {
			e.printStackTrace();
			session(request).invalidate();
			request.getSession();
			request.setAttribute("alertMessage", e.getMessage());
			dispatchRequest(request, response, "/");
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
		case "/customer/account": {
			request.setAttribute("accounts", customerOperation.getAssociatedAccounts(customer.getUserId()));
			dispatchRequest(request, response, "/WEB-INF/jsp/customer/accounts.jsp");
		}
			break;

		case "/customer/account_details": {
			Long accountNumber = Long.parseLong(request.getParameter("account_number"));
			Account account = customerOperation.getAccountDetails(accountNumber, customer.getUserId());
			List<Transaction> transactions = customerOperation.getTransactionsOfAccount(accountNumber, 1,
					TransactionHistoryLimit.RECENT);
			Branch branch = customerOperation.getBranchDetailsOfAccount(account.getBranchId());
			request.setAttribute("account", account);
			request.setAttribute("transactions", transactions);
			request.setAttribute("branch", branch);
			dispatchRequest(request, response, "/WEB-INF/jsp/customer/account_details.jsp");
		}
			break;

		case "/customer/statement": {
			Map<Long, Account> accounts = (Map<Long, Account>) customerOperation
					.getAssociatedAccounts(customer.getUserId());
			request.setAttribute("accounts", accounts);
			dispatchRequest(request, response, "/WEB-INF/jsp/customer/statement_select.jsp");
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
		case "/customer/statement": {
			long accountNumber = Long.parseLong(request.getParameter("account_number"));
			TransactionHistoryLimit limit = TransactionHistoryLimit
					.valueOf(request.getParameter("transaction_limit").toString());
			List<Transaction> transactions = customerOperation.getTransactionsOfAccount(accountNumber, 1, limit);
			request.setAttribute("transactions", transactions);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/customer/statement_view.jsp");
			dispatcher.forward(request, response);
		}
			break;

		case "/customer/authorization": {
			String operation = request.getParameter("operation");
			switch (operation) {
			case "authorize_transaction": {
				long viewer_account_number = Long.parseLong(request.getParameter("from-account"));
				long transacted_account_number = Long.parseLong(request.getParameter("to-account"));
				double amount = Double.parseDouble(request.getParameter("amount"));
				String transferWithinBankString = request.getParameter("transferWithinBank");
				boolean transferWithinBank = !Objects.isNull(transferWithinBankString);
				String ifsc = request.getParameter("ifsc");
				String remarks = request.getParameter("remarks");

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
				String pin = request.getParameter("pin");
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

			case "authorize_change_password": {
				String oldPassword = (String) request.getParameter("oldPassword");
				String newPassword = (String) request.getParameter("newPassword");
				try {
					appOperation.getUser(customer.getUserId(), oldPassword);
					request.getSession(false).setAttribute("oldPassword", oldPassword);
					request.getSession(false).setAttribute("newPassword", newPassword);
					RequestDispatcher dispatcher = request.getRequestDispatcher(
							"/WEB-INF/jsp/customer/authorization.jsp?redirect=process_change_password");
					dispatcher.forward(request, response);
				} catch (AppException e) {
					request.setAttribute("status", false);
					request.setAttribute("operation", "password_change");
					request.setAttribute("message", e.getMessage());
					request.setAttribute("redirect", "change_password");
					RequestDispatcher dispatcher = request
							.getRequestDispatcher("/WEB-INF/jsp/customer/transaction_status.jsp");
					dispatcher.forward(request, response);
				}
			}
				break;
			case "process_change_password": {
				String oldPassword = (String) request.getSession(false).getAttribute("oldPassword");
				String newPassword = (String) request.getSession(false).getAttribute("newPassword");
				String pin = (String) request.getParameter("pin");

				try {
					customerOperation.updatePassword(customer.getUserId(), oldPassword, newPassword, pin);
					request.setAttribute("status", true);
					request.setAttribute("operation", "password_change");
					request.setAttribute("message", "New password has been updated");
					request.setAttribute("redirect", "logout");
				} catch (AppException e) {
					request.setAttribute("status", false);
					request.setAttribute("operation", "password_change");
					request.setAttribute("message", e.getMessage());
					request.setAttribute("redirect", "change_password");
				}
				RequestDispatcher dispatcher = request
						.getRequestDispatcher("/WEB-INF/jsp/customer/transaction_status.jsp");
				dispatcher.forward(request, response);
			}
				break;
			case "authorize_profile_update": {
				String oldAddress = (String) request.getParameter("old_address");
				String newAddress = (String) request.getParameter("new_address");
				String oldEmail = (String) request.getParameter("old_email");
				String newEmail = (String) request.getParameter("new_email");
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
				String pin = (String) request.getParameter("pin");
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
			}
		}
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
		case "/employee/branch_accounts": {
			request.setAttribute("accounts", employeeOperation.getListOfAccountsInBranch(employee.getUserId(), 1));
			request.setAttribute("branch", employeeOperation.getBrachDetails(employee.getBranchId()));
			dispatchRequest(request, response, "/WEB-INF/jsp/employee/branch_accounts.jsp");
		}
			break;

		case "/employee/account_details": {
			Long accountNumber = Long.parseLong(request.getParameter("account_number"));
			Account account = employeeOperation.getAccountDetails(accountNumber);
			CustomerRecord customer = employeeOperation.getCustomerRecord(account.getUserId());
			request.setAttribute("account", account);
			request.setAttribute("customer", customer);
			dispatchRequest(request, response, "/WEB-INF/jsp/employee/account_details.jsp");
		}
			break;

		case "/employee/open_account": {
			dispatchRequest(request, response, "/WEB-INF/jsp/employee/open_account.jsp");
		}
			break;

		case "/employee/statement": {
			dispatchRequest(request, response, "/WEB-INF/jsp/employee/statement_select.jsp");
		}
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
		case "/employee/open_account": {
			String customerType = request.getParameter("customer");
			AccountType type = AccountType.valueOf(request.getParameter("type"));
			double amount = Double.parseDouble(request.getParameter("amount"));
			try {
				if (customerType.equals("new")) {
					CustomerRecord newCustomer = new CustomerRecord();
					newCustomer.setFirstName(request.getParameter("firstName"));
					newCustomer.setLastName(request.getParameter("lastName"));
					newCustomer.setDateOfBirth(ConvertorUtil.dateStringToMillis(request.getParameter("dateOfBirth")));
					newCustomer.setGender(Integer.parseInt(request.getParameter("gender")));
					newCustomer.setAddress(request.getParameter("address"));
					newCustomer.setPhone(Long.parseLong(request.getParameter("mobile")));
					newCustomer.setEmail(request.getParameter("email"));
					newCustomer.setAadhaarNumber(Long.parseLong(request.getParameter("aadhar")));
					newCustomer.setPanNumber(request.getParameter("pan"));
					Account newAccount = employeeOperation.createNewCustomerAndAccount(newCustomer, type, amount,
							employee.getUserId());
					request.setAttribute("message", "New customer and account has been created\nCustomer ID : "
							+ newCustomer.getUserId() + "\nAccount Number : " + newAccount.getAccountNumber());
				} else if (customerType.equals("existing")) {
					int customerId = Integer.parseInt(request.getParameter("userId"));
					Account newAccount = employeeOperation.createAccountForExistingCustomer(customerId, type, amount,
							employee.getUserId());
					request.setAttribute("message",
							"New account has been created\nAccount Number : " + newAccount.getAccountNumber());
				}
				request.setAttribute("status", true);
			} catch (AppException e) {
				request.setAttribute("status", false);
				request.setAttribute("message", e.getMessage());
			}
			request.setAttribute("operation", "open_account");
			request.setAttribute("redirect", "branch_accounts");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/customer/transaction_status.jsp");
			dispatcher.forward(request, response);
		}
			break;

		case "/employee/statement": {
			long accountNumber = Long.parseLong(request.getParameter("account_number"));
			String limitString = request.getParameter("transaction_limit");
			try {
				List<Transaction> transactions;
				if (limitString.equals("custom")) {
					long startDate = ConvertorUtil.dateStringToMillis(request.getParameter("startDate"));
					long endDate = ConvertorUtil.dateStringToMillis(request.getParameter("endDate"));
					System.out.println(startDate);
					System.out.println(endDate);
					transactions = employeeOperation.getListOfTransactions(accountNumber, 1, startDate, endDate);
				} else {
					TransactionHistoryLimit limit = TransactionHistoryLimit.valueOf(limitString);
					transactions = employeeOperation.getListOfTransactions(accountNumber, 1, limit);
				}
				request.setAttribute("transactions", transactions);
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/employee/statement_view.jsp");
				dispatcher.forward(request, response);
			} catch (AppException e) {
				e.printStackTrace();
				request.setAttribute("status", false);
				request.setAttribute("message", e.getMessage());
				request.setAttribute("operation", "statement");
				request.setAttribute("redirect", "statement");
				RequestDispatcher dispatcher = request
						.getRequestDispatcher("/WEB-INF/jsp/customer/transaction_status.jsp");
				dispatcher.forward(request, response);
			}
		}
			break;
		}
	}
}
