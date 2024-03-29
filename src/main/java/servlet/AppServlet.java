package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import exceptions.AppException;
import modules.Account;
import modules.Branch;
import modules.CustomerRecord;
import modules.Transaction;
import modules.UserRecord;
import operations.AppOperations;
import operations.CustomerOperations;
import utility.ValidatorUtil;
import utility.ConstantsUtil.ModifiableField;
import utility.ConstantsUtil.TransactionHistoryLimit;
import utility.ConstantsUtil.UserType;

@WebServlet("/")
public class AppServlet extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {

			System.out.println(request.getServletPath());
			System.out.println(request.getPathInfo());
			System.out.println(request.getPathTranslated());
			System.out.println(request.getServletPath());

			AppOperations appOperation = new AppOperations();
			CustomerOperations customerOperation = new CustomerOperations();

			String route = request.getParameter("route");

			if (route.equals("login")) {
				int userId = Integer.parseInt(request.getParameter("userId"));
				String password = request.getParameter("password");
				try {
					UserRecord user = appOperation.getUser(userId, password);
					HttpSession session = request.getSession(false);
					session.setAttribute("user", user);
					if (user.getType() == UserType.CUSTOMER) {
						Map<Long, Account> accounts = customerOperation.getAssociatedAccounts(userId);
						request.setAttribute("accounts", accounts);
						RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/customer/accounts.jsp");
						dispatcher.forward(request, response);
					} else {
						request.setAttribute("alert", "Not registered as a Customer");
						RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
						dispatcher.forward(request, response);
					}
				} catch (AppException e) {
					request.setAttribute("alert", e.getMessage());
					RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
					dispatcher.forward(request, response);
				}
			}

			else {
				if (Objects.isNull(getUser(request))) {
					RequestDispatcher dispatch = request.getRequestDispatcher("index.jsp");
					dispatch.forward(request, response);
				} else {
					switch (route) {

					case "authorization_request": {
						long viewer_account_number = Long.parseLong(request.getParameter("from-account"));
						long transacted_account_number = Long.parseLong(request.getParameter("to-account"));
						double amount = Double.parseDouble(request.getParameter("amount"));
						String transferWithinBankString = request.getParameter("transferWithinBank");
						boolean trasferWithinBank = !Objects.isNull(transferWithinBankString);
						String remarks = request.getParameter("remarks");

						Transaction transaction = new Transaction();
						transaction.setViewerAccountNumber(viewer_account_number);
						transaction.setTransactedAccountNumber(transacted_account_number);
						transaction.setTransactedAmount(amount);
						transaction.setRemarks(remarks);

						request.getSession(false).setAttribute("transaction", transaction);
						request.getSession(false).setAttribute("transferWithinBank", trasferWithinBank);
						RequestDispatcher dispatcher = request
								.getRequestDispatcher("jsp/customer/authorization.jsp?redirect=authorize");
						dispatcher.forward(request, response);
					}
						break;

					case "authorize": {

						UserRecord user = getUser(request);
						String pin = request.getParameter("pin");
						HttpSession session = request.getSession(false);
						Transaction transaction = (Transaction) session.getAttribute("transaction");
						session.removeAttribute("transaction");
						transaction.setUserId(user.getUserId());
						boolean transferWithinBank = (boolean) session.getAttribute("transferWithinBank");
						session.removeAttribute("transferWithinBank");

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
								.getRequestDispatcher("jsp/customer/transaction_status.jsp");
						dispatcher.forward(request, response);

					}
						break;

					case "change_password_authorization_request": {
						String oldPassword = (String) request.getParameter("oldPassword");
						String newPassword = (String) request.getParameter("newPassword");

						try {
							appOperation.getUser(getUser(request).getUserId(), oldPassword);
							request.getSession(false).setAttribute("oldPassword", oldPassword);
							request.getSession(false).setAttribute("newPassword", newPassword);
							RequestDispatcher dispatcher = request.getRequestDispatcher(
									"jsp/customer/authorization.jsp?redirect=authorize_change_password");
							dispatcher.forward(request, response);
						} catch (AppException e) {
							request.setAttribute("status", false);
							request.setAttribute("operation", "password_change");
							request.setAttribute("message", e.getMessage());
							request.setAttribute("redirect", "change_password");
							RequestDispatcher dispatcher = request
									.getRequestDispatcher("jsp/customer/transaction_status.jsp");
							dispatcher.forward(request, response);
						}
					}
						break;

					case "authorize_change_password": {
						String oldPassword = (String) request.getSession(false).getAttribute("oldPassword");
						String newPassword = (String) request.getSession(false).getAttribute("newPassword");
						String pin = (String) request.getParameter("pin");

						try {
							customerOperation.updatePassword(getUser(request).getUserId(), oldPassword, newPassword,
									pin);
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
								.getRequestDispatcher("jsp/customer/transaction_status.jsp");
						dispatcher.forward(request, response);
					}
						break;

					case "customer_profile_update_request": {
						String oldAddress = (String) request.getParameter("old_address");
						String newAddress = (String) request.getParameter("new_address");
						String oldEmail = (String) request.getParameter("old_email");
						String newEmail = (String) request.getParameter("new_email");
						boolean addressChangeNeeded = !oldAddress.equals(newAddress);
						boolean emailChangeNeeded = !oldEmail.equals(newEmail);
						String url = "authorization.jsp?redirect=profile_update_authorization";
						if (!addressChangeNeeded && !emailChangeNeeded) {
							url = "profile.jsp";
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
						RequestDispatcher dispatch = request.getRequestDispatcher("jsp/customer/" + url);
						dispatch.forward(request, response);
					}
						break;

					case "profile_update_authorization": {
						String pin = (String) request.getParameter("pin");
						HttpSession session = request.getSession(false);
						try {
							List<ModifiableField> fields = (List<ModifiableField>) session.getAttribute("fields");
							int customerId = getUser(request).getUserId();
							for (ModifiableField field : fields) {
								Object value = session.getAttribute(field.toString().toLowerCase());
								customerOperation.updateUserDetails(customerId, field, value, pin);
							}
							CustomerRecord user = customerOperation.getCustomerRecord(customerId);
							System.out.println(user.getAddress());
							session.setAttribute("user", user);

							request.setAttribute("status", true);
							request.setAttribute("operation", "profile_update");
							request.setAttribute("message",
									"The profile details have been updated\nThe changes will be updated shortly");
							request.setAttribute("redirect", "customer_profile");
						} catch (AppException e) {
							e.printStackTrace();
							request.setAttribute("status", true);
							request.setAttribute("operation", "profile_update");
							request.setAttribute("message", "An error occured. " + e.getMessage());
							request.setAttribute("redirect", "customer_profile");
						}
						RequestDispatcher dispatcher = request
								.getRequestDispatcher("jsp/customer/transaction_status.jsp");
						dispatcher.forward(request, response);
					}
						break;

					default: {
						RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
						dispatcher.forward(request, response);
					}
						break;
					}
				}
			}
		} catch (Exception e) {
			throw new ServletException(e);

		}
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			if (Objects.isNull(getUser(request))) {
				RequestDispatcher dispatch = request.getRequestDispatcher("index.jsp");
				dispatch.forward(request, response);
			}

			else {
				AppOperations appOperation = new AppOperations();
				CustomerOperations customerOperation = new CustomerOperations();
				String route = request.getParameter("route");

				switch (route) {

				case "account": {
					UserRecord user = (UserRecord) request.getSession(false).getAttribute("user");
					if (user.getType() == UserType.CUSTOMER) {
						Map<Long, Account> accounts = customerOperation.getAssociatedAccounts(user.getUserId());
						request.setAttribute("accounts", accounts);
						RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/customer/accounts.jsp");
						dispatcher.forward(request, response);
					}
				}
					break;

				case "account_details": {
					UserRecord user = (UserRecord) request.getSession(false).getAttribute("user");
					Long accountNumber = Long.parseLong(request.getParameter("account_number"));
					Account account = customerOperation.getAccountDetails(accountNumber, user.getUserId());
					System.out.println(account.getLastTransactedAt());
					List<Transaction> transactions = customerOperation.getTransactionsOfAccount(accountNumber, 1,
							TransactionHistoryLimit.RECENT);
					Branch branch = customerOperation.getBranchDetailsOfAccount(account.getBranchId());
					request.setAttribute("account", account);
					request.setAttribute("transactions", transactions);
					request.setAttribute("branch", branch);
					RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/customer/account_details.jsp");
					dispatcher.forward(request, response);
				}
					break;

				case "transfer": {
					UserRecord user = (UserRecord) request.getSession(false).getAttribute("user");
					System.out.println(user.getUserId());
					Map<Long, Account> accounts = (Map<Long, Account>) customerOperation
							.getAssociatedAccounts(user.getUserId());
					request.setAttribute("accounts", accounts);
					RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/customer/transfer.jsp");
					dispatcher.forward(request, response);
				}
					break;

				case "statement_select": {
					UserRecord user = (UserRecord) request.getSession(false).getAttribute("user");
					System.out.println(user.getUserId());
					Map<Long, Account> accounts = (Map<Long, Account>) customerOperation
							.getAssociatedAccounts(user.getUserId());
					request.setAttribute("accounts", accounts);
					RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/customer/statement_select.jsp");
					dispatcher.forward(request, response);
				}
					break;

				case "statement_view": {
					long accountNumber = Long.parseLong(request.getParameter("account_number"));
					TransactionHistoryLimit limit = TransactionHistoryLimit
							.valueOf(request.getParameter("transaction_limit").toString());

					List<Transaction> transactions = customerOperation.getTransactionsOfAccount(accountNumber, 1,
							limit);
					request.setAttribute("transactions", transactions);
					RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/customer/statement_view.jsp");
					dispatcher.forward(request, response);
				}
					break;

				case "change_password": {
					RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/customer/change_password.jsp");
					dispatcher.forward(request, response);
				}
					break;

				case "customer_profile": {
					RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/customer/profile.jsp");
					dispatcher.forward(request, response);
				}
					break;

				case "customer_profile_edit": {
					RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/customer/profile_edit.jsp");
					dispatcher.forward(request, response);
				}
					break;

				case "logout": {
					request.getSession(false).invalidate();
					RequestDispatcher dispatch = request.getRequestDispatcher("index.jsp");
					dispatch.forward(request, response);
					break;
				}

				default: {
					RequestDispatcher dispatch = request.getRequestDispatcher("index.jsp");
					dispatch.forward(request, response);
				}
					break;
				}
			}

		} catch (Exception e) {
			throw new ServletException(e.getMessage(), e);
		}
	}

	private UserRecord getUser(HttpServletRequest request) throws AppException {
		ValidatorUtil.validateObject(request);
		HttpSession session = request.getSession(false);
		if (!Objects.isNull(session)) {
			return (UserRecord) session.getAttribute("user");
		}
		return null;
	}
}
