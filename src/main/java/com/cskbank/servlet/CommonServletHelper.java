package com.cskbank.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.cskbank.api.mickey.MickeyUserAPI;
import com.cskbank.cache.CachePool;
import com.cskbank.exceptions.AppException;
import com.cskbank.exceptions.messages.APIExceptionMessage;
import com.cskbank.exceptions.messages.ServletExceptionMessage;
import com.cskbank.filters.Parameters;
import com.cskbank.modules.Account;
import com.cskbank.modules.AuditLog;
import com.cskbank.modules.CustomerRecord;
import com.cskbank.modules.OTP;
import com.cskbank.modules.Transaction;
import com.cskbank.modules.UserRecord;
import com.cskbank.modules.UserRecord.Type;
import com.cskbank.test.MickeyLiteTest;
import com.cskbank.utility.ConstantsUtil;
import com.cskbank.utility.ConstantsUtil.Gender;
import com.cskbank.utility.ConstantsUtil.LogOperation;
import com.cskbank.utility.ConstantsUtil.OperationStatus;
import com.cskbank.utility.ConstantsUtil.Status;
import com.cskbank.utility.ConstantsUtil.TransactionHistoryLimit;
import com.cskbank.utility.ConvertorUtil;
import com.cskbank.utility.LogUtil;
import com.cskbank.utility.MailGenerationUtil;
import com.cskbank.utility.SecurityUtil;
import com.cskbank.utility.ServletUtil;
import com.cskbank.utility.ValidatorUtil;

class CommonServletHelper {

	public void loginPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, ServletException, IOException {
		int userId = ConvertorUtil.convertStringToInteger(request.getParameter(Parameters.USERID.parameterName()));
		String password = request.getParameter(Parameters.PASSWORD.parameterName());
		UserRecord user = null;
		try {
			HandlerObject.adminHandler.getPageCountOfBranches();
			user = HandlerObject.commonHandler.getUser(userId, password);
			if (user.getStatus() == Status.VERIFICATION) {
				ServletUtil.session(request).setAttribute("unverified_user", user);
				response.sendRedirect(request.getContextPath() + "/verification");

				AuditLog log = new AuditLog();
				log.setUserId(userId);
				log.setLogOperation(LogOperation.USER_VERIFICATION);
				log.setOperationStatus(OperationStatus.PROCESSING);
				log.setDescription(
						"User(ID : " + userId + ") has logged in, yet to be verified. Redirected to verification page");
				log.setModifiedAtWithCurrentTime();
				HandlerObject.auditHandler.log(log);

				sendMailIfOTPAbsent(user);

			} else if (user.getStatus() == Status.BLOCKED) {
				request.getRequestDispatcher("/WEB-INF/jsp/common/blocked.jsp").forward(request, response);

				AuditLog log = new AuditLog();
				log.setUserId(userId);
				log.setLogOperation(LogOperation.USER_LOGIN);
				log.setOperationStatus(OperationStatus.FAILURE);
				log.setDescription("User(ID : " + userId + ") login failed - User has been blocked");
				log.setModifiedAtWithCurrentTime();
				HandlerObject.auditHandler.log(log);
			} else {
				ServletUtil.session(request).setAttribute("user", user);
				response.sendRedirect(user.getType().toString().toLowerCase() + "/home");

				// Log
				AuditLog log = new AuditLog();
				log.setUserId(userId);
				log.setLogOperation(LogOperation.USER_LOGIN);
				log.setOperationStatus(OperationStatus.SUCCESS);
				log.setDescription(user.getType() + "(ID : " + userId + ") has successfully logged in");
				log.setModifiedAtWithCurrentTime();
				HandlerObject.auditHandler.log(log);
			}
		} catch (AppException e) {
			AuditLog log = new AuditLog();
			log.setUserId(userId);
			log.setLogOperation(LogOperation.USER_LOGIN);
			log.setOperationStatus(OperationStatus.FAILURE);
			log.setDescription("User(ID : " + userId + ") login failed - " + e.getMessage());
			log.setModifiedAtWithCurrentTime();
			HandlerObject.auditHandler.log(log);

			ServletUtil.session(request).setAttribute(AppException.class.getName(), e);

			throw e;
		}
	}

	private void sendMailIfOTPAbsent(UserRecord user) throws AppException {
		ValidatorUtil.validateObject(user);
		if (!CachePool.getOTPCache().isValidOTPPresent(user.getEmail())) {
			MailGenerationUtil.sendVerificationOTPMail(user.getEmail());

			AuditLog log = new AuditLog();
			log.setUserId(user.getUserId());
			log.setTargetId(user.getUserId());
			log.setLogOperation(LogOperation.OTP_SENT_TO_USER);
			log.setOperationStatus(OperationStatus.SUCCESS);
			log.setDescription("OTP not found. A new otp was generated and sent to Customer(ID : " + user.getUserId()
					+ ") - Email ID - " + user.getEmail());
			log.setModifiedAt(System.currentTimeMillis());
			HandlerObject.auditHandler.log(log);
		}
	}

	public void signupPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {
		String email = request.getParameter(Parameters.EMAIL.parameterName());
		if (HandlerObject.commonHandler.doesEmailExist(email)) {
			request.getSession().setAttribute("error", "User already exists with the given email address");
			response.sendRedirect(request.getContextPath() + "/signup");
			return;
		}
		try {
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
			newCustomer.setEmail(email);
			newCustomer.setAadhaarNumber(
					ConvertorUtil.convertStringToLong(request.getParameter(Parameters.AADHAAR.parameterName())));
			newCustomer.setPanNumber(request.getParameter(Parameters.PAN.parameterName()));
			newCustomer.setStatus(Status.VERIFICATION);

			HandlerObject.employeeHandler.createNewCustomerFromSignup(newCustomer);
			ServletUtil.session(request).setAttribute("unverified_user", newCustomer);

			AuditLog log = new AuditLog();
			log.setUserId(newCustomer.getUserId());
			log.setLogOperation(LogOperation.CREATE_CUSTOMER_AT_SIGNUP);
			log.setOperationStatus(OperationStatus.PROCESSING);
			log.setDescription("Customer(ID : " + newCustomer.getUserId()
					+ ") was initiated at signup Admin(ID : 1) and OTP sent to email");
			log.setModifiedAt(newCustomer.getCreatedAt());
			HandlerObject.auditHandler.log(log);

			MailGenerationUtil.sendVerificationOTPMail(newCustomer.getEmail());
			log = new AuditLog();
			log.setUserId(newCustomer.getUserId());
			log.setLogOperation(LogOperation.OTP_SENT_TO_USER);
			log.setOperationStatus(OperationStatus.SUCCESS);
			log.setDescription("An otp was generated and sent to Customer(ID : " + newCustomer.getUserId()
					+ ") - Email ID - " + email);
			log.setModifiedAt(newCustomer.getCreatedAt());
			HandlerObject.auditHandler.log(log);

			MailGenerationUtil.sendUserSignupMail(newCustomer);
			log = new AuditLog();
			log.setUserId(newCustomer.getUserId());
			log.setLogOperation(LogOperation.CREATE_CUSTOMER_AT_SIGNUP);
			log.setOperationStatus(OperationStatus.SUCCESS);
			log.setDescription(
					"Sign up email was sent to User(ID : " + newCustomer.getUserId() + ") - Email ID - " + email);
			log.setModifiedAt(newCustomer.getCreatedAt());
			HandlerObject.auditHandler.log(log);

			ServletUtil.session(request).setAttribute("error", "OTP Sent to Email");
			request.getSession().setAttribute("verify_email", email);
			response.sendRedirect(request.getContextPath() + "/verification");
			// Log

		} catch (AppException e) {
			AuditLog log = new AuditLog();
			log.setUserId(1);
			log.setLogOperation(LogOperation.CREATE_CUSTOMER_AT_SIGNUP);
			log.setOperationStatus(OperationStatus.FAILURE);
			log.setDescription("Cannot create new customer. Reason : " + e.getMessage());
			log.setModifiedAt(System.currentTimeMillis());
			HandlerObject.auditHandler.log(log);

			throw e;
		}
	}

	public void resendGetRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {
		UserRecord unverifiedUser = (UserRecord) ServletUtil.session(request).getAttribute("unverified_user");
		if (unverifiedUser == null) {
			ServletUtil.session(request).setAttribute("error", "No verification user found");
			response.sendRedirect(ServletUtil.getRedirectContextURL(request, "login"));
			return;
		}

		if (CachePool.getOTPCache().isValidOTPPresent(unverifiedUser.getEmail())) {
			OTP currentOTP = CachePool.getOTPCache().getOTP(unverifiedUser.getEmail());
			if (currentOTP.getRegenerationCount() < 1) {
				currentOTP.remove();
				HandlerObject.adminHandler.blockUser(unverifiedUser);
				long time = CachePool.getUserRecordCache().refreshData(unverifiedUser.getUserId()).getModifiedAt();
				ServletUtil.session(request).removeAttribute("unverified_user");
				request.getRequestDispatcher("/WEB-INF/jsp/common/blocked.jsp").forward(request, response);

				AuditLog log = new AuditLog();
				log.setUserId(unverifiedUser.getUserId());
				log.setLogOperation(LogOperation.USER_BLOCKED);
				log.setOperationStatus(OperationStatus.SUCCESS);
				log.setDescription(
						"User(ID : " + unverifiedUser.getUserId() + ") was blocked for regenerating OTP continuously");
				log.setModifiedAt(time);
				HandlerObject.auditHandler.log(log);
				return;
			}

			MailGenerationUtil.sendVerificationOTPMail(unverifiedUser.getEmail(),
					currentOTP.getRegenerationCount() - 1);

			AuditLog log = new AuditLog();
			log.setUserId(unverifiedUser.getUserId());
			log.setLogOperation(LogOperation.OTP_REGENERATED);
			log.setOperationStatus(OperationStatus.SUCCESS);
			log.setDescription("OTP was resent to Customer(ID : " + unverifiedUser.getUserId() + ") - Email ID - "
					+ unverifiedUser.getEmail() + ". Resends remaining : " + (currentOTP.getRegenerationCount() - 1));
			log.setModifiedAt(System.currentTimeMillis());
			HandlerObject.auditHandler.log(log);
			ServletUtil.session(request).setAttribute("error", "OTP resent successfully");

		} else {
			MailGenerationUtil.sendVerificationOTPMail(unverifiedUser.getEmail());

			AuditLog log = new AuditLog();
			log.setUserId(unverifiedUser.getUserId());
			log.setLogOperation(LogOperation.OTP_REGENERATED);
			log.setOperationStatus(OperationStatus.SUCCESS);
			log.setDescription("OTP not found. An otp was generated at resend request Customer(ID : "
					+ unverifiedUser.getUserId() + ") - Email ID - " + unverifiedUser.getEmail());
			log.setModifiedAt(System.currentTimeMillis());
			HandlerObject.auditHandler.log(log);
			ServletUtil.session(request).setAttribute("error", "OTP resent successfully");
		}
		response.sendRedirect(ServletUtil.getRedirectContextURL(request, "app/verification"));
	}

	public void verificationGetRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {
		UserRecord unverifiedUser = (UserRecord) ServletUtil.session(request).getAttribute("unverified_user");
		if (unverifiedUser == null) {
			ServletUtil.session(request).setAttribute("error", "No verification user found");
			response.sendRedirect(ServletUtil.getRedirectContextURL(request, "login"));
			return;
		}
		if (!CachePool.getOTPCache().isValidOTPPresent(unverifiedUser.getEmail())) {
			MailGenerationUtil.sendVerificationOTPMail(unverifiedUser.getEmail());

			AuditLog log = new AuditLog();
			log.setUserId(unverifiedUser.getUserId());
			log.setTargetId(unverifiedUser.getUserId());
			log.setLogOperation(LogOperation.OTP_SENT_TO_USER);
			log.setOperationStatus(OperationStatus.SUCCESS);
			log.setDescription("OTP not found. A new otp was generated and sent to Customer(ID : "
					+ unverifiedUser.getUserId() + ") - Email ID - " + unverifiedUser.getEmail());
			log.setModifiedAt(System.currentTimeMillis());
			HandlerObject.auditHandler.log(log);

			ServletUtil.session(request).setAttribute("error", "OTP sent to user's mail");
		}
		request.getRequestDispatcher("/WEB-INF/jsp/common/verification.jsp").forward(request, response);
		response.sendRedirect(ServletUtil.getRedirectContextURL(request, "login"));
	}

	public void verificationPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {
		UserRecord unverifiedUser = (UserRecord) ServletUtil.session(request).getAttribute("unverified_user");
		if (unverifiedUser == null) {
			ServletUtil.session(request).setAttribute("error", "No verification user found");
			response.sendRedirect(ServletUtil.getRedirectContextURL(request, "login"));
			return;
		}
		String email = unverifiedUser.getEmail();
		String obtainedOTP = request.getParameter(Parameters.OTP.parameterName());

		ValidatorUtil.validateOTP(obtainedOTP);
		ValidatorUtil.validateEmail(email);

		sendMailIfOTPAbsent(unverifiedUser);
		OTP otp = CachePool.getOTPCache().getOTP(email);

		if (otp.getRegenerationCount() < 1 || otp.getRetryCount() < 1) {
			CachePool.getOTPCache().removeOTP(otp.getEmail());
			HandlerObject.adminHandler.blockUser(unverifiedUser);
			long time = CachePool.getUserRecordCache().refreshData(unverifiedUser.getUserId()).getModifiedAt();
			ServletUtil.session(request).removeAttribute("unverified_user");
			request.getRequestDispatcher("/WEB-INF/jsp/common/blocked.jsp").forward(request, response);

			AuditLog log = new AuditLog();
			log.setUserId(unverifiedUser.getUserId());
			log.setLogOperation(LogOperation.USER_BLOCKED);
			log.setOperationStatus(OperationStatus.SUCCESS);
			log.setDescription(
					"User(ID : " + unverifiedUser.getUserId() + ") was blocked for entering wrong OTP continuously");
			log.setModifiedAt(time);
			HandlerObject.auditHandler.log(log);
			return;
		}

		if (otp.isOTPExpired()) {
			CachePool.getOTPCache().removeOTP(otp.getEmail());
			ServletUtil.session(request).setAttribute("error",
					"Your OTP has expired. A new mail has been sent to your email. Please retry");

			MailGenerationUtil.sendVerificationOTPMail(unverifiedUser.getEmail(), otp.getRegenerationCount() - 1);
			request.getRequestDispatcher("/WEB-INF/jsp/common/verification.jsp").forward(request, response);

			AuditLog log = new AuditLog();
			log.setUserId(unverifiedUser.getUserId());
			log.setLogOperation(LogOperation.OTP_SENT_TO_USER);
			log.setOperationStatus(OperationStatus.SUCCESS);
			log.setDescription(
					"An otp was generated due to expired OTP and sent to Customer(ID : " + unverifiedUser.getUserId()
							+ ") - Email ID - " + email + ". Regeneration remaining : " + otp.getRegenerationCount());
			log.setModifiedAt(System.currentTimeMillis());
			HandlerObject.auditHandler.log(log);
			return;
		}

		if (!otp.getOTP().equals(obtainedOTP)) {
			otp.reduceRetryCount();
			CachePool.getOTPCache().setOTP(otp);
			ServletUtil.session(request).setAttribute("error",
					"OTP Entered is incorrect. Number of Attemps left : " + otp.getRetryCount());
			request.getRequestDispatcher("/WEB-INF/jsp/common/verification.jsp").forward(request, response);

			AuditLog log = new AuditLog();
			log.setUserId(unverifiedUser.getUserId());
			log.setLogOperation(LogOperation.WRONG_OTP_ENTERED);
			log.setOperationStatus(OperationStatus.FAILURE);
			log.setDescription("Wrong OTP Entered by Customer(ID : " + unverifiedUser.getUserId() + ") - Email ID - "
					+ email + ". Remaining Retries : " + otp.getRetryCount());
			log.setModifiedAt(System.currentTimeMillis());
			HandlerObject.auditHandler.log(log);
			return;
		}

		CachePool.getOTPCache().removeOTP(otp.getEmail());
		HandlerObject.adminHandler.activateUserWithOTPVerification(unverifiedUser);
		AuditLog log = new AuditLog();
		log.setUserId(unverifiedUser.getUserId());
		log.setLogOperation(LogOperation.USER_VERIFICATION);
		log.setOperationStatus(OperationStatus.SUCCESS);
		log.setDescription("User(ID : " + unverifiedUser.getUserId() + ") verification is successful");
		log.setModifiedAt(System.currentTimeMillis());
		HandlerObject.auditHandler.log(log);

		ServletUtil.session(request).removeAttribute("unverified_user");
		ServletUtil.session(request).setAttribute("user", unverifiedUser);
		ServletUtil.session(request).setAttribute("error", "User verification successful");
		response.sendRedirect(
				request.getContextPath() + "/app/" + unverifiedUser.getType().toString().toLowerCase() + "/home");
		log.setUserId(unverifiedUser.getUserId());
		log.setLogOperation(LogOperation.USER_LOGIN);
		log.setOperationStatus(OperationStatus.SUCCESS);
		log.setDescription(
				unverifiedUser.getType() + "(ID : " + unverifiedUser.getUserId() + ") has successfully logged in");
		log.setModifiedAtWithCurrentTime();
		HandlerObject.auditHandler.log(log);
	}

	public void statementPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, ServletException, IOException {
		long accountNumber = ConvertorUtil
				.convertStringToLong(request.getParameter(Parameters.ACCOUNTNUMBER.parameterName()));
		String limitString = request.getParameter(Parameters.TRANSACTIONLIMIT.parameterName());
		int currentPage = ConvertorUtil
				.convertStringToInteger(request.getParameter(Parameters.CURRENTPAGE.parameterName()));
		int pageCount = ConvertorUtil
				.convertStringToInteger(request.getParameter(Parameters.PAGECOUNT.parameterName()));
		if (pageCount < currentPage) {
			currentPage = 1;
		}

		List<Transaction> transactions;
		Account account = null;
		UserRecord user = ServletUtil.getUser(request);
		if (user.getType() == UserRecord.Type.CUSTOMER) {
			account = HandlerObject.customerHandler.getAccountDetails(accountNumber, user.getUserId());
		} else if (user.getType() == Type.EMPLOYEE || user.getType() == Type.ADMIN) {
			account = HandlerObject.employeeHandler.getAccountDetails(accountNumber);
		}

		if (limitString.equals("custom")) {
			String startDateString = request.getParameter(Parameters.STARTDATE.parameterName());
			String endDateString = request.getParameter(Parameters.ENDDATE.parameterName());
			long startDate = ConvertorUtil.dateStringToMillis(startDateString);
			long endDate = ConvertorUtil.dateStringToMillisWithCurrentTime(endDateString);
			if (pageCount <= 0) {
				pageCount = HandlerObject.commonHandler.getPageCountOfTransactions(accountNumber, startDate, endDate);
			}
			transactions = HandlerObject.commonHandler.getTransactionsOfAccount(account, currentPage, startDate,
					endDate);
			request.setAttribute("startDate", startDateString);
			request.setAttribute("endDate", endDateString);
		} else {
			TransactionHistoryLimit limit = TransactionHistoryLimit.convertStringToEnum(limitString);
			if (pageCount <= 0) {
				pageCount = HandlerObject.commonHandler.getPageCountOfTransactions(accountNumber, limit);
			}
			transactions = HandlerObject.commonHandler.getTransactionsOfAccount(account, currentPage, limit);
		}
		request.setAttribute("limit", limitString);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("accountNumber", accountNumber);
		request.setAttribute("transactions", transactions);
		request.getRequestDispatcher("/WEB-INF/jsp/common/statement_view.jsp").forward(request, response);
	}

	public void passwordChangeAuthorizationPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, ServletException, IOException {
		String oldPassword = request.getParameter(Parameters.OLDPASSWORD.parameterName());
		String newPassword = request.getParameter(Parameters.NEWPASSWORD.parameterName());
		try {
			HandlerObject.commonHandler.getUser(ServletUtil.getUser(request).getUserId(), oldPassword);
			ServletUtil.session(request).setAttribute("oldPassword", oldPassword);
			ServletUtil.session(request).setAttribute("newPassword", newPassword);
			ServletUtil.session(request).setAttribute("redirect", "process_change_password");
			response.sendRedirect("authorization");
		} catch (AppException e) {
			LogUtil.logException(e);

			ServletUtil.session(request).setAttribute("error", e.getMessage());
			response.sendRedirect("change_password");
		}
	}

	public void passwordChangeProcessPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, ServletException, IOException {
		String oldPassword = ServletUtil.getSessionObject(request, "oldPassword");
		String newPassword = ServletUtil.getSessionObject(request, "newPassword");
		String pin = request.getParameter(Parameters.PIN.parameterName());
		UserRecord user = ServletUtil.getUser(request);

		try {
			HandlerObject.commonHandler.updatePassword(user.getUserId(), oldPassword, newPassword, pin);
			ServletUtil.session(request).invalidate();

			// Log
			AuditLog log = new AuditLog();
			log.setUserId(user.getUserId());
			log.setLogOperation(LogOperation.UPDATE_PASSWORD);
			log.setOperationStatus(OperationStatus.SUCCESS);
			log.setDescription(user.getType() + "(ID : " + user.getUserId() + ") has changed the password");
			log.setModifiedAtWithCurrentTime();
			HandlerObject.auditHandler.log(log);

			request.getSession(true).setAttribute("error", "Password has been changed.");
		} catch (AppException e) {
			ServletUtil.session(request).setAttribute("error", "Cannot change password : " + e.getMessage());
			// Log
			AuditLog log = new AuditLog();
			log.setUserId(user.getUserId());
			log.setLogOperation(LogOperation.UPDATE_PASSWORD);
			log.setOperationStatus(OperationStatus.FAILURE);
			log.setDescription("Password update failed - " + e.getMessage());
			log.setModifiedAtWithCurrentTime();
			HandlerObject.auditHandler.log(log);
		}
		response.sendRedirect(ServletUtil.getLoginRedirect(request));
	}

	public void passwordResetGetRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, ServletException, IOException {
		String prHash = request.getParameter(Parameters.ID.parameterName());
		prHash = prHash.replace(" ", "+");
		try {
			JSONObject json = new JSONObject(SecurityUtil.decryptCipher(prHash));
			long timeout = json.getLong("timeout");

			if (System.currentTimeMillis() > timeout) {
				ServletUtil.session(request).setAttribute("error", "Reset Password Link Expired");
				response.sendRedirect(ServletUtil.getLoginRedirect(request));
				return;
			} else {
				request.getRequestDispatcher("/WEB-INF/jsp/common/reset_password_input.jsp").forward(request, response);
				return;
			}

		} catch (Exception e) {
			LogUtil.logException(e);
			throw new AppException(ServletExceptionMessage.INVALID_OBJECT);
		}
	}

	public void passwordResetRequestPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, ServletException, IOException {

		int userId = ConvertorUtil.convertStringToInteger(request.getParameter(Parameters.USERID.parameterName()));
		String email = request.getParameter(Parameters.EMAIL.parameterName());

		if (HandlerObject.commonHandler.doesEmailBelongsToUser(userId, email)) {
			JSONObject json = new JSONObject();
			json.put("userId", userId);
			json.put("timeout", System.currentTimeMillis() + ConstantsUtil.EXPIRY_DURATION_MILLIS);

			String prHash = SecurityUtil.encryptText(json.toString());
			MailGenerationUtil.sendPasswordResetMail(email,
					"https://localhost:8443" + ServletUtil.getRedirectContextURL(request, "app/rp?id=" + prHash));

			AuditLog log = new AuditLog();
			log.setUserId(userId);
			log.setLogOperation(LogOperation.PASSWORD_RESET_MAIL);
			log.setOperationStatus(OperationStatus.SUCCESS);
			log.setDescription("Password reset mail has been sent to User(ID : " + userId + ")");
			log.setModifiedAtWithCurrentTime();
			HandlerObject.auditHandler.log(log);

			request.setAttribute("status", true);
			request.setAttribute("message", "Password Reset Mail has been sent to your email");
			request.setAttribute("redirect", "/CSKBankingApplication/login");

			request.getRequestDispatcher("/WEB-INF/jsp/common/transaction_status.jsp").forward(request, response);
			return;
		} else {
			throw new AppException(APIExceptionMessage.USER_EMAIL_INCORRECT);
		}
	}

	public void passwordResetActionPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, ServletException, IOException {
		String newPassword = request.getParameter(Parameters.NEWPASSWORD.parameterName());
		String confirmPassword = request.getParameter(Parameters.CONFIRM_PASSWORD.parameterName());
		String id = request.getParameter(Parameters.ID.parameterName());
		id = id.replace(" ", "+");

		try {
			if (!newPassword.equals(confirmPassword)) {
				throw new AppException(ServletExceptionMessage.PASSWORDS_DONT_MATCH);
			}

			JSONObject json = new JSONObject(SecurityUtil.decryptCipher(id));
			long timeout = json.getLong("timeout");
			if (System.currentTimeMillis() >= timeout) {
				throw new AppException(ServletExceptionMessage.PASSWORD_RESET_LINK_EXPIRED);
			}

			int userId = json.getInt("userId");
			if (HandlerObject.commonHandler.resetPassword(userId, newPassword)) {
				AuditLog log = new AuditLog();
				log.setUserId(userId);
				log.setLogOperation(LogOperation.RESET_PASSWORD);
				log.setOperationStatus(OperationStatus.SUCCESS);
				log.setDescription("User(ID : " + userId + ") has reset the password through email link");
				log.setModifiedAtWithCurrentTime();
				HandlerObject.auditHandler.log(log);

				ServletUtil.session(request).setAttribute("error", "Password has been reset");
				response.sendRedirect(ServletUtil.getLoginRedirect(request));
			} else {
				ServletUtil.session(request).setAttribute("error", "An error occured during password reset");
				response.sendRedirect(ServletUtil.getRedirectContextURL(request, "app/rp?id=" + id));
			}

		} catch (Exception e) {
			throw new AppException(e.getMessage());
		}

	}
}
