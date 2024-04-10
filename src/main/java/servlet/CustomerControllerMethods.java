package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import exceptions.AppException;
import exceptions.messages.ActivityExceptionMessages;
import filters.Parameters;
import modules.Account;
import modules.Branch;
import modules.CustomerRecord;
import modules.Transaction;
import operations.AppOperations;
import operations.CustomerOperations;
import utility.ConvertorUtil;
import utility.ServletUtil;
import utility.ValidatorUtil;
import utility.ConstantsUtil.LogOperation;
import utility.ConstantsUtil.ModifiableField;
import utility.ConstantsUtil.OperationStatus;

public class CustomerControllerMethods {

	public CustomerControllerMethods() throws AppException {
	}

	private CustomerOperations operations = new CustomerOperations();
	private AppOperations appOperations = new AppOperations();

	public void accountsGetRequest(HttpServletRequest request, HttpServletResponse response, String forwardFileName)
			throws ServletException, IOException, AppException {
		CustomerRecord customer = (CustomerRecord) ServletUtil.getUser(request);
		ValidatorUtil.validateObject(forwardFileName);
		request.setAttribute("accounts", operations.getAssociatedAccounts(customer.getUserId()));
		request.getRequestDispatcher("/WEB-INF/jsp/" + forwardFileName + ".jsp").forward(request, response);
	}

	public void accountDetailsGetRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {
		CustomerRecord customer = (CustomerRecord) ServletUtil.getUser(request);
		Long accountNumber = ConvertorUtil
				.convertStringToLong(request.getParameter(Parameters.ACCOUNTNUMBER.parameterName()));
		Account account = operations.getAccountDetails(accountNumber, customer.getUserId());
		Branch branch = operations.getBranchDetailsOfAccount(account.getBranchId());
		request.setAttribute("account", account);
		request.setAttribute("branch", branch);
		request.getRequestDispatcher("/WEB-INF/jsp/customer/account_details.jsp").forward(request, response);
	}

	public void authorizeTransactionPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		try {
			CustomerRecord customer = (CustomerRecord) ServletUtil.getUser(request);

			long viewer_account_number = ConvertorUtil
					.convertStringToLong(request.getParameter(Parameters.FROMACCOUNT.parameterName()));
			long transacted_account_number = ConvertorUtil
					.convertStringToLong(request.getParameter(Parameters.TOACCOUNT.parameterName()));
			if (viewer_account_number == transacted_account_number) {
				throw new AppException(ActivityExceptionMessages.CANNOT_TRANSFER_TO_SAME_ACCOUNT);
			}
			double amount = ConvertorUtil
					.convertStringToDouble(request.getParameter(Parameters.AMOUNT.parameterName()));

			String transferWithinBankString = request.getParameter(Parameters.TRANSFERWITHINBANK.parameterName());
			boolean transferWithinBank = !Objects.isNull(transferWithinBankString);
			String ifsc = request.getParameter(Parameters.IFSC.parameterName());
			String remarks = request.getParameter(Parameters.REMARKS.parameterName());

			ValidatorUtil.validateAmount(amount);

			Transaction transaction = new Transaction();
			transaction.setViewerAccountNumber(
					operations.getAccountDetails(viewer_account_number, customer.getUserId()).getAccountNumber());
			transaction.setTransactedAccountNumber(transacted_account_number);
			transaction.setTransactedAmount(amount);
			transaction.setRemarks(remarks);
			transaction.setUserId(customer.getUserId());

			ServletUtil.session(request).setAttribute("transaction", transaction);
			ServletUtil.session(request).setAttribute("transferWithinBank", transferWithinBank);
			request.getRequestDispatcher("/WEB-INF/jsp/common/authorization.jsp?redirect=process_transaction")
					.forward(request, response);
		} catch (AppException e) {
			ServletUtil.session(request).setAttribute("error", e.getMessage());
			response.sendRedirect("transfer");
		}
	}

	public void processTransactionPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException, AppException {
		Transaction transaction = (Transaction) ServletUtil.session(request).getAttribute("transaction");
		String pin = request.getParameter(Parameters.PIN.parameterName());
		ServletUtil.session(request).removeAttribute("transaction");
		boolean transferWithinBank = (boolean) ServletUtil.session(request).getAttribute("transferWithinBank");
		ServletUtil.session(request).removeAttribute("transferWithinBank");

		try {
			Transaction completedTransaction = operations.tranferMoney(transaction, transferWithinBank, pin);
			request.setAttribute("status", true);
			request.setAttribute("message",
					"Your Transaction has been completed!\n Tranaction ID : " + transaction.getTransactionId());
			request.setAttribute("redirect", "account");

			// Log
			appOperations.logOperationByAndForUser(transaction.getUserId(), LogOperation.USER_TRANSACTION,
					OperationStatus.SUCCESS,
					"Customer(ID : " + transaction.getUserId() + ") has transfered "
							+ ConvertorUtil.amountToCurrencyFormat(transaction.getTransactedAmount())
							+ " to Account(Acc/No : " + transaction.getTransactedAccountNumber() + ")",
					completedTransaction.getCreatedAt());

		} catch (AppException e) {
			e.printStackTrace();
			request.setAttribute("status", false);
			request.setAttribute("message", e.getMessage());
			request.setAttribute("redirect", "transfer");

			// Log
			appOperations.logOperationByAndForUser(transaction.getUserId(), LogOperation.USER_TRANSACTION,
					OperationStatus.SUCCESS,
					"Transaction by Customer(ID : " + transaction.getUserId() + ") has failed - " + e.getMessage(),
					System.currentTimeMillis());
		}
		request.getRequestDispatcher("/WEB-INF/jsp/common/transaction_status.jsp").forward(request, response);
	}

	public void authorizeProfileUpdatePostRequest(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		try {
			String oldAddress = request.getParameter("old_address");
			String newAddress = request.getParameter("new_address");
			String oldEmail = request.getParameter("old_email");
			String newEmail = request.getParameter("new_email");
			boolean addressChangeNeeded = !oldAddress.equals(newAddress);
			boolean emailChangeNeeded = !oldEmail.equals(newEmail);
			if (!addressChangeNeeded && !emailChangeNeeded) {
				ServletUtil.session(request).setAttribute("error", "No change was detected");
				response.sendRedirect("profile");
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
			request.getRequestDispatcher("/WEB-INF/jsp/common/authorization.jsp?redirect=process_profile_update")
					.forward(request, response);
		} catch (Exception e) {
			ServletUtil.session(request).setAttribute("error", e.getMessage());
			response.sendRedirect("profile");
		}
	}

	public void processProfileUpdatePostRequest(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException, AppException {
		CustomerRecord customer = (CustomerRecord) ServletUtil.getUser(request);
		String pin = request.getParameter(Parameters.PIN.parameterName());
		int customerId = customer.getUserId();
		try {
			List<ModifiableField> fields = (List) ServletUtil.session(request).getAttribute("fields");
			for (ModifiableField field : fields) {
				Object value = ServletUtil.session(request).getAttribute(field.toString().toLowerCase());
				operations.updateUserDetails(customerId, field, value, pin);
			}
			CustomerRecord user = operations.getCustomerRecord(customerId);
			ServletUtil.session(request).setAttribute("user", user);
			request.setAttribute("status", true);
			request.setAttribute("operation", "profile_update");
			request.setAttribute("message",
					"The profile details have been updated\nThe changes will be reflected shortly");
			request.setAttribute("redirect", "profile");

			// Log
			appOperations.logOperationByAndForUser(customerId, LogOperation.UPDATE_PROFILE, OperationStatus.SUCCESS,
					"Profile details Customer(ID : " + customerId + ") has been successfully updated",
					System.currentTimeMillis());
		} catch (AppException e) {
			e.printStackTrace();
			request.setAttribute("status", true);
			request.setAttribute("operation", "profile_update");
			request.setAttribute("message", "An error occured. " + e.getMessage());
			request.setAttribute("redirect", "profile");

			// Log
			appOperations.logOperationByAndForUser(customerId, LogOperation.UPDATE_PROFILE, OperationStatus.FAILURE,
					"Profile details Customer(ID : " + customerId + ") failed - " + e.getMessage(),
					System.currentTimeMillis());
		}
		request.getRequestDispatcher("/WEB-INF/jsp/common/transaction_status.jsp").forward(request, response);
	}
}
