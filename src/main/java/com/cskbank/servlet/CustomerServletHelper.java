package com.cskbank.servlet;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cskbank.exceptions.AppException;
import com.cskbank.exceptions.messages.APIExceptionMessage;
import com.cskbank.exceptions.messages.ActivityExceptionMessages;
import com.cskbank.exceptions.messages.ServletExceptionMessage;
import com.cskbank.filters.Parameters;
import com.cskbank.modules.Account;
import com.cskbank.modules.AuditLog;
import com.cskbank.modules.Branch;
import com.cskbank.modules.CustomerRecord;
import com.cskbank.modules.Transaction;
import com.cskbank.modules.UserRecord;
import com.cskbank.utility.ConstantsUtil.LogOperation;
import com.cskbank.utility.ConstantsUtil.ModifiableField;
import com.cskbank.utility.ConstantsUtil.OperationStatus;
import com.cskbank.utility.ConstantsUtil.Status;
import com.cskbank.utility.ConvertorUtil;
import com.cskbank.utility.LogUtil;
import com.cskbank.utility.ServletUtil;
import com.cskbank.utility.ValidatorUtil;

class CustomerServletHelper {

	public void accountsGetRequest(HttpServletRequest request, HttpServletResponse response, String forwardFileName)
			throws ServletException, IOException, AppException {
		CustomerRecord customer = (CustomerRecord) ServletUtil.getUser(request);
		ValidatorUtil.validateObject(forwardFileName);
		request.setAttribute("accounts", HandlerObject.customerHandler.getAssociatedAccounts(customer.getUserId()));
		request.getRequestDispatcher("/WEB-INF/jsp/" + forwardFileName + ".jsp").forward(request, response);
	}

	public void accountDetailsGetRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {
		CustomerRecord customer = (CustomerRecord) ServletUtil.getUser(request);
		Long accountNumber = ConvertorUtil
				.convertStringToLong(request.getParameter(Parameters.ACCOUNTNUMBER.parameterName()));
		Account account = HandlerObject.customerHandler.getAccountDetails(accountNumber, customer.getUserId());
		Branch branch = HandlerObject.customerHandler.getBranchDetailsOfAccount(account.getBranchId());
		request.setAttribute("account", account);
		request.setAttribute("branch", branch);
		request.getRequestDispatcher("/WEB-INF/jsp/customer/account_details.jsp").forward(request, response);
	}

	public void authorizeTransactionPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException, AppException {

		CustomerRecord customer = (CustomerRecord) ServletUtil.getUser(request);

		long viewer_account_number = ConvertorUtil
				.convertStringToLong(request.getParameter(Parameters.FROMACCOUNT.parameterName()));
		long transacted_account_number = ConvertorUtil
				.convertStringToLong(request.getParameter(Parameters.TOACCOUNT.parameterName()));
		if (viewer_account_number == transacted_account_number) {
			throw new AppException(ActivityExceptionMessages.CANNOT_TRANSFER_TO_SAME_ACCOUNT);
		}
		double amount = ConvertorUtil.convertStringToDouble(request.getParameter(Parameters.AMOUNT.parameterName()));

		String transferWithinBankString = request.getParameter(Parameters.TRANSFERWITHINBANK.parameterName());
		if (transferWithinBankString != null && !transferWithinBankString.equals("on")) {
			throw new AppException("Invalid Identifier Obtained : Transfer Within Bank");
		}

		boolean transferWithinBank = !Objects.isNull(transferWithinBankString);
//			String ifsc = request.getParameter(Parameters.IFSC.parameterName());
		String remarks = request.getParameter(Parameters.REMARKS.parameterName());

		ValidatorUtil.validateAmount(amount);

		Account senderAccount = HandlerObject.customerHandler.getAccountDetails(viewer_account_number,
				customer.getUserId());
		if (senderAccount.getStatus() == Status.FROZEN) {
			throw new AppException(APIExceptionMessage.ACCOUNT_FROZEN);
		}

		if (senderAccount.getStatus() == Status.CLOSED) {
			throw new AppException(APIExceptionMessage.ACCOUNT_CLOSED);
		}

		Transaction transaction = new Transaction();
		transaction.setViewerAccountNumber(senderAccount.getAccountNumber());
		transaction.setTransactedAccountNumber(transacted_account_number);
		transaction.setTransactedAmount(amount);
		transaction.setRemarks(remarks);
		transaction.setUserId(customer.getUserId());
		if (transferWithinBank) {
			HandlerObject.employeeHandler.getAccountDetails(transacted_account_number);
			transaction.setTransferWithinBank();
		} else {
			transaction.setTransferOutsideBank();
		}

		ServletUtil.session(request).setAttribute("transaction", transaction);
		ServletUtil.session(request).setAttribute("redirect", "process_transaction");
		response.sendRedirect("authorization");
	}

	public void processTransactionPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException, AppException {
		Transaction transaction = ServletUtil.getSessionObject(request, "transaction");
		if (transaction == null) {
			ServletUtil.session(request).setAttribute("error", "Invalid transaction");
			response.sendRedirect("transfer");
			return;
		}

		String pin = request.getParameter(Parameters.PIN.parameterName());

		try {
			Transaction completedTransaction = HandlerObject.customerHandler.tranferMoney(transaction,
					transaction.getTransferWithinBank(), pin);
			request.setAttribute("status", true);
			request.setAttribute("message",
					"Your Transaction has been completed!\n Tranaction ID : " + transaction.getTransactionId());

			// Log
			AuditLog log = new AuditLog();
			log.setUserId(transaction.getUserId());
			log.setLogOperation(LogOperation.USER_TRANSACTION);
			log.setOperationStatus(OperationStatus.SUCCESS);
			log.setDescription("Customer(ID : " + transaction.getUserId() + ") has transfered "
					+ ConvertorUtil.amountToCurrencyFormat(transaction.getTransactedAmount())
					+ " from Account(Acc/No : " + transaction.getViewerAccountNumber() + ")" + " to Account(Acc/No : "
					+ transaction.getTransactedAccountNumber() + ")");
			log.setModifiedAt(completedTransaction.getCreatedAt());
			HandlerObject.auditHandler.log(log);

		} catch (AppException e) {
			LogUtil.logException(e);
			request.setAttribute("status", false);
			request.setAttribute("message", e.getMessage());

			// Log
			AuditLog log = new AuditLog();
			log.setUserId(transaction.getUserId());
			log.setLogOperation(LogOperation.USER_TRANSACTION);
			log.setOperationStatus(OperationStatus.FAILURE);
			log.setDescription(
					"Transaction by Customer(ID : " + transaction.getUserId() + ") has failed - " + e.getMessage());
			log.setModifiedAtWithCurrentTime();
			HandlerObject.auditHandler.log(log);

		}
		request.setAttribute("redirect", "transfer");
		request.getRequestDispatcher("/WEB-INF/jsp/common/transaction_status.jsp").forward(request, response);
	}

	public void authorizeProfileUpdatePostRequest(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
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
		ServletUtil.session(request).setAttribute("redirect", "process_profile_update");
		response.sendRedirect("authorization");
	}

	public void processProfileUpdatePostRequest(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException, AppException {
		UserRecord user = ServletUtil.getUser(request);
		String pin = request.getParameter(Parameters.PIN.parameterName());
		int customerId = user.getUserId();
		try {
			List<ModifiableField> fields = (List) ServletUtil.session(request).getAttribute("fields");
			for (ModifiableField field : fields) {
				Object value = ServletUtil.session(request).getAttribute(field.toString().toLowerCase());
				ServletUtil.session(request).removeAttribute(field.toString().toLowerCase());
				HandlerObject.customerHandler.updateUserDetails(customerId, field, value, pin);
			}
			user = HandlerObject.customerHandler.getCustomerRecord(customerId);
			ServletUtil.session(request).setAttribute("user", user);
			ServletUtil.session(request).removeAttribute("fields");
			request.setAttribute("status", true);
			request.setAttribute("message",
					"The profile details have been updated\nThe changes will be reflected shortly");

			// Log
			AuditLog log = new AuditLog();
			log.setUserId(user.getUserId());
			log.setLogOperation(LogOperation.UPDATE_PROFILE);
			log.setOperationStatus(OperationStatus.SUCCESS);
			log.setDescription("Profile details " + user.getType() + "(ID : " + user.getUserId()
					+ ") has been successfully updated");
			log.setModifiedAt(user.getModifiedAt());
			HandlerObject.auditHandler.log(log);

		} catch (AppException e) {
			LogUtil.logException(e);
			request.setAttribute("status", false);
			request.setAttribute("message", "An error occured. " + e.getMessage());

			// Log
			AuditLog log = new AuditLog();
			log.setUserId(customerId);
			log.setLogOperation(LogOperation.UPDATE_PASSWORD);
			log.setOperationStatus(OperationStatus.FAILURE);
			log.setDescription("Profile details update for " + user.getType() + "(ID : " + customerId + ") failed - "
					+ e.getMessage());
			log.setModifiedAtWithCurrentTime();
			HandlerObject.auditHandler.log(log);

		}
		request.setAttribute("redirect", "profile");
		request.getRequestDispatcher("/WEB-INF/jsp/common/transaction_status.jsp").forward(request, response);
	}
}
