package servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.cj.Session;

import exceptions.AppException;
import modules.Account;
import modules.Branch;
import modules.Transaction;
import modules.UserRecord;
import operations.AppOperations;
import operations.CustomerOperations;
import utility.ConstantsUtil.TransactionHistoryLimit;
import utility.ConstantsUtil.UserType;

public class AppServlet extends HttpServlet {

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			AppOperations appOperation = new AppOperations();
			CustomerOperations customerOperation = new CustomerOperations();

			String route = request.getParameter("route");

			switch (route) {
			case "login": {
				int userId = Integer.parseInt(request.getParameter("userId"));
				String password = request.getParameter("password");
				UserRecord user = appOperation.getUser(userId, password);
				HttpSession session = request.getSession();
				session.setAttribute("user", user);
				if (user.getType() == UserType.CUSTOMER) {
					Map<Long, Account> accounts = customerOperation.getAssociatedAccounts(userId);
					request.setAttribute("accounts", accounts);
					RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/customer/accounts.jsp");
					dispatcher.forward(request, response);
				}
			}
				break;

			case "account": {
				UserRecord user = (UserRecord) request.getSession().getAttribute("user");
				if (user.getType() == UserType.CUSTOMER) {
					Map<Long, Account> accounts = customerOperation.getAssociatedAccounts(user.getUserId());
					request.setAttribute("accounts", accounts);
					RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/customer/accounts.jsp");
					dispatcher.forward(request, response);
				}
			}
				break;

			case "account_details": {
				UserRecord user = (UserRecord) request.getSession().getAttribute("user");
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

			case "statement_select": {
				UserRecord user = (UserRecord) request.getSession().getAttribute("user");
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

				List<Transaction> transactions = customerOperation.getTransactionsOfAccount(accountNumber, 1, limit);
				request.setAttribute("transactions", transactions);
				RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/customer/statement_view.jsp");
				dispatcher.forward(request, response);
			}
				break;

			case "transfer": {
				UserRecord user = (UserRecord) request.getSession().getAttribute("user");
				System.out.println(user.getUserId());
				Map<Long, Account> accounts = (Map<Long, Account>) customerOperation
						.getAssociatedAccounts(user.getUserId());
				request.setAttribute("accounts", accounts);
				RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/customer/transfer.jsp");
				dispatcher.forward(request, response);
			}
				break;

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

				System.out.println(transferWithinBankString);
				System.out.println(trasferWithinBank);

				request.getSession().setAttribute("transaction", transaction);
				request.getSession().setAttribute("transferWithinBank", trasferWithinBank);
				RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/customer/authorization.jsp");
				dispatcher.forward(request, response);
			}
				break;

			case "authorize": {
				UserRecord user = (UserRecord) request.getSession().getAttribute("user");
				String pin = request.getParameter("pin");
				System.out.println(request.getSession().getAttribute("transaction"));
				System.out.println(request.getSession().getAttribute("transferWithinBank"));
				RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/customer/authorization.jsp");
				dispatcher.forward(request, response);
			}
				break;

			default:
				break;
			}
		} catch (AppException e) {
			throw new ServletException(e);
		}
	}
}
