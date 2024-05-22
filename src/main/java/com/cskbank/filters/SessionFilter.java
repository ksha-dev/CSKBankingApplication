package com.cskbank.filters;

import java.io.IOException;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cskbank.cache.CachePool;
import com.cskbank.exceptions.AppException;
import com.cskbank.exceptions.SessionFilterException;
import com.cskbank.modules.AuditLog;
import com.cskbank.modules.OTP;
import com.cskbank.modules.UserRecord;
import com.cskbank.servlet.Services;
import com.cskbank.utility.MailGenerationUtil;
import com.cskbank.utility.ServletUtil;
import com.cskbank.utility.ValidatorUtil;
import com.cskbank.utility.ConstantsUtil.LogOperation;
import com.cskbank.utility.ConstantsUtil.OperationStatus;
import com.cskbank.utility.ConstantsUtil.Status;

/**
 * Servlet Filter implementation class SessionFilter
 */
@WebFilter("/SessionFilter")
public class SessionFilter implements Filter {

	/**
	 * Default constructor.
	 * 
	 * @throws AppException
	 */
	public SessionFilter() throws AppException {
		Services.initialize();
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;

		HttpSession session = req.getSession(false);
		String controller = req.getServletPath();
		String controllerSuffix = req.getPathInfo();
		String contextPath = req.getContextPath();

		try {
			sessionCheck(req);
			rootControllerCheck(req);
		} catch (SessionFilterException e) {
			if (e.isErrorAvailable()) {
				ServletUtil.session(req).setAttribute("error", e.getMessage());
			}

			if (e.isRedirect()) {
				res.sendRedirect(e.getURL());
			} else {
				req.getRequestDispatcher(e.getURL()).forward(req, res);
			}
		}

		if (controller.equals("/login") || controller.equals("/signup")) {
			UserRecord user = (UserRecord) session.getAttribute("user");
			if (user != null) {
				res.sendRedirect("app/" + user.getType().toString().toLowerCase() + "/home");
			} else {
				req.getRequestDispatcher("/WEB-INF/jsp/common" + controller + ".jsp").forward(req, res);
			}
		} else if (controller.equals("/verification")) {
			UserRecord user = (UserRecord) session.getAttribute("user");
			if (user != null) {
				session.setAttribute("error", "User already verified");
				res.sendRedirect("app/" + user.getType().toString().toLowerCase() + "/home");
				return;
			}
			user = (UserRecord) session.getAttribute("unverified_user");
			if (user == null) {
				session.setAttribute("error", "An Error occured during verification - User not found");
				res.sendRedirect(contextPath + "/login");
				return;
			}
			try {
				try {
					ServletUtil.checkRequiredParameters(req.getParameterMap(), List.of(Parameters.OPERATION));
					if (req.getParameter(Parameters.OPERATION.parameterName()) == "resend"
							&& Services.otpCache.isValidOTPPresent(user.getEmail())) {
						OTP currentOTP = Services.otpCache.getOTP(user.getEmail());
						currentOTP.reduceRetryCount();
					}
				} catch (AppException e) {
				}
				if (!Services.otpCache.isValidOTPPresent(user.getEmail())) {
					MailGenerationUtil.sendVerificationOTPMail(user.getEmail());

					AuditLog log = new AuditLog();
					log.setUserId(user.getUserId());
					log.setTargetId(user.getUserId());
					log.setLogOperation(LogOperation.OTP_SENT_TO_USER);
					log.setOperationStatus(OperationStatus.SUCCESS);
					log.setDescription("OTP not found. A new otp was generated and sent to Customer(ID : "
							+ user.getUserId() + ") - Email ID - " + user.getEmail());
					log.setModifiedAt(System.currentTimeMillis());
					Services.auditLogService.log(log);
				} else {
					req.getRequestDispatcher("/WEB-INF/jsp/common/verification.jsp").forward(req, res);
					return;
				}
			} catch (AppException e) {
				session.setAttribute("error", "An error occured - " + e.getMessage());
				res.sendRedirect(contextPath + "/login");
			}
		} else if (controllerSuffix == null) {
			res.sendRedirect(contextPath + "/login");

		} else if (controllerSuffix.endsWith("/logout")) {
			session.invalidate();
			res.sendRedirect(contextPath + "/login");

		} else if (controller.equals("/app")
				&& (controllerSuffix.equals("/login") || controllerSuffix.equals("/signup"))) {

			chain.doFilter(req, res);

		} else if (controller.equals("/app")
				&& (controllerSuffix.equals("/resend") || controllerSuffix.equals("/verification"))) {
			UserRecord user = (UserRecord) session.getAttribute("unverified_user");
			chain.doFilter(req, res);

		} else if (session.getAttribute("user") == null) {
			session.invalidate();
			req.getSession(true).setAttribute("error", "The Session has expired. Login again to access the bank");
			res.sendRedirect(contextPath + "/login");

		} else {
			try {
				UserRecord sessionUser = (UserRecord) session.getAttribute("user");
				UserRecord updatedUser = CachePool.getUserRecordCache().get(sessionUser.getUserId());
				if (sessionUser.getStatus() != updatedUser.getStatus()) {
					session.invalidate();
					req.getSession(true).setAttribute("error",
							"The Session has expired. Login again to access the bank");
					res.sendRedirect(contextPath + "/login");
				} else {
					session.setAttribute("user", updatedUser);
					chain.doFilter(req, res);
				}
			} catch (AppException e) {
				session.invalidate();
				req.getSession(true).setAttribute("error", e.getMessage());
				res.sendRedirect(contextPath + "/login");
			}
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

	public void sessionCheck(HttpServletRequest request) throws IOException, SessionFilterException {
		if (request.getSession(false) == null) {
			throw new SessionFilterException("Session not found", ServletUtil.getRedirectContextURL(request, "login"),
					true);
		}
	}

	@SuppressWarnings("unused")
	public void sessionObjectCheck(HttpServletRequest request)
			throws SessionFilterException, IOException, ServletException {
		UserRecord user = ServletUtil.getUser(request);
		UserRecord unverifiedUser = ServletUtil.getUnverifiedUser(request);
		String controller = request.getServletPath();

		// User Object Checks
		if (user == null && controller != "/verification") {
			if (unverifiedUser != null) {
				ServletUtil.session(request).removeAttribute("unverified_user");
			}
			throw new SessionFilterException("Invalid session obtained. Please login again",
					ServletUtil.getLoginRedirect(request), true);
		}

		if (user != null) {
			try {
				UserRecord updatedUser = CachePool.getUserRecordCache().get(user.getUserId());
				if (updatedUser.getStatus() != user.getStatus()) {
					request.getSession(false).removeAttribute("user");
					throw new SessionFilterException("User has been modified. Please login again",
							ServletUtil.getLoginRedirect(request), true);
				} else {
					if (updatedUser.getStatus() == Status.BLOCKED) {
						request.getSession(false).removeAttribute("user");
						throw new SessionFilterException("/WEB-INF/jsp/common/blocked.jsp", false);
					}

					else if (updatedUser.getStatus() == Status.VERIFICATION) {
						request.getSession(false).removeAttribute("user");
						request.getSession(false).setAttribute("unverified_user", updatedUser);
						throw new SessionFilterException(ServletUtil.getRedirectContextURL(request, "verification"),
								true);
					} else {
						ServletUtil.session(request).setAttribute("user", updatedUser);
						throw new SessionFilterException();
					}
				}
			} catch (AppException e) {
				ServletUtil.session(request).invalidate();
				throw new SessionFilterException(ServletUtil.getLoginRedirect(request), true);
			}
		}

		// Unverified User Object checks
		if (unverifiedUser == null && controller == "/verification") {
			throw new SessionFilterException("Invalid verification. Please login again",
					ServletUtil.getLoginRedirect(request), true);
		}

		if (unverifiedUser.getStatus() == Status.BLOCKED) {
			request.getSession(false).removeAttribute("unverified_user");
			throw new SessionFilterException("/WEB-INF/jsp/common/blocked.jsp", false);
		}

		if (unverifiedUser.getStatus() != Status.VERIFICATION) {
			request.getSession(false).removeAttribute("unverified_user");
			throw new SessionFilterException("User has been modified. Please login again",
					ServletUtil.getRedirectContextURL(request, "login"), true);
		}

		else if (unverifiedUser != null) {
			try {
				UserRecord updatedUser = CachePool.getUserRecordCache().get(unverifiedUser.getUserId());
				if (unverifiedUser.getStatus() != Status.VERIFICATION
						|| updatedUser.getStatus() != unverifiedUser.getStatus()) {
					request.getSession(false).removeAttribute("unverified_user");
					throw new SessionFilterException("User cannot be verified. Please login again",
							ServletUtil.getRedirectContextURL(request, "verification"), true);
				} else {
					ServletUtil.session(request).setAttribute("unverified_user", updatedUser);
					throw new SessionFilterException();
				}
			} catch (AppException e) {
				request.getSession(false).removeAttribute("unverified_user");
				throw new SessionFilterException(e.getMessage(), ServletUtil.getLoginRedirect(request), true);
			}
		}
	}

	public void userObjectCheck(HttpServletRequest request)
			throws SessionFilterException, IOException, ServletException {
		UserRecord user = ServletUtil.getUser(request);
		UserRecord updatedUser = null;

		try {
			updatedUser = CachePool.getUserRecordCache().get(user.getUserId());
		} catch (AppException e) {
			ServletUtil.session(request).removeAttribute("user");
			throw new SessionFilterException("User integrity check failed. Please login again",
					ServletUtil.getLoginRedirect(request), true);
		}

		if (updatedUser.getStatus() != user.getStatus()) {
			request.getSession(false).removeAttribute("user");
			throw new SessionFilterException("User has been modified. Please login again",
					ServletUtil.getLoginRedirect(request), true);
		}

		if (updatedUser.getStatus() == Status.BLOCKED) {
			request.getSession(false).removeAttribute("user");
			throw new SessionFilterException("/WEB-INF/jsp/common/blocked.jsp", false);
		}

		if (updatedUser.getStatus() == Status.VERIFICATION) {
			request.getSession(false).removeAttribute("user");
			request.getSession(false).setAttribute("unverified_user", updatedUser);
			throw new SessionFilterException(ServletUtil.getRedirectContextURL(request, "verification"), true);
		}

		ServletUtil.session(request).setAttribute("user", updatedUser);
	}

	public void unverifiedObjectCheck(HttpServletRequest request)
			throws SessionFilterException, ServletException, IOException {
		UserRecord unverifiedUser = ServletUtil.getUnverifiedUser(request);
		UserRecord updatedUser = null;

		try {
			updatedUser = CachePool.getUserRecordCache().get(unverifiedUser.getUserId());
		} catch (AppException e) {
			request.getSession(false).removeAttribute("unverified_user");
			throw new SessionFilterException("User integrity check failed. Please login again",
					ServletUtil.getLoginRedirect(request), true);
		}

		if (unverifiedUser.getStatus() != Status.VERIFICATION
				|| updatedUser.getStatus() != unverifiedUser.getStatus()) {
			request.getSession(false).removeAttribute("unverified_user");
			throw new SessionFilterException("User cannot be verified. Please login again",
					ServletUtil.getRedirectContextURL(request, "verification"), true);
		}

		if (unverifiedUser.getStatus() == Status.BLOCKED) {
			request.getSession(false).removeAttribute("unverified_user");
			throw new SessionFilterException("/WEB-INF/jsp/common/blocked.jsp", false);
		}

		if (unverifiedUser.getStatus() != Status.VERIFICATION) {
			request.getSession(false).removeAttribute("unverified_user");
			throw new SessionFilterException("User has been modified. Please login again",
					ServletUtil.getRedirectContextURL(request, "login"), true);
		}
	}

	public void rootControllerCheck(HttpServletRequest request)
			throws SessionFilterException, ServletException, IOException {
		String controller = request.getServletPath();
		controller = controller.replaceFirst("/", "");
		HttpSession session = ServletUtil.session(request);
		UserRecord user = ServletUtil.getUser(request);
		UserRecord unverifiedUser = ServletUtil.getUnverifiedUser(request);

		switch (controller) {
		case "verification":
			if (unverifiedUser == null && user == null) {
				throw new SessionFilterException("Invalid verification. Please login again",
						ServletUtil.getLoginRedirect(request), true);
			} else if (user != null) {
				throw new SessionFilterException("User already verified", ServletUtil.getRedirectContextURL(request,
						"app" + user.getStatus().toString().toLowerCase() + "/home"), true);
			}

		case "login":
		case "signup":
			if (user == null) {
				if (unverifiedUser != null) {
					session.removeAttribute("unverified_user");
				}
				throw new SessionFilterException("Invalid session obtained. Please login again",
						ServletUtil.getLoginRedirect(request), true);
			}

		}

//		if (controller.equals("/login") || controller.equals("/signup")) {
//			if (user != null) {
//				res.sendRedirect("app/" + user.getType().toString().toLowerCase() + "/home");
//			} else {
//				req.getRequestDispatcher("/WEB-INF/jsp/common" + controller + ".jsp").forward(req, res);
//			}
//		}
	}

}
