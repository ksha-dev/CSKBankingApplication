package com.cskbank.filters;

import java.io.IOException;

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

import com.cskbank.exceptions.AppException;
import com.cskbank.mail.OTPMail;
import com.cskbank.modules.AuditLog;
import com.cskbank.modules.UserRecord;
import com.cskbank.servlet.Services;
import com.cskbank.utility.ServletUtil;
import com.cskbank.utility.ConstantsUtil.LogOperation;
import com.cskbank.utility.ConstantsUtil.OperationStatus;

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

		if (session == null) {
			req.getSession(true).setAttribute("error", "The Session has expired. Login again to access the bank");
			res.sendRedirect(contextPath + "/login");
		} else if (controller.equals("/login") || controller.equals("/signup")) {
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
				if (!Services.otpDatabase.isValidOTPPresent(user.getEmail())) {
					OTPMail.generateOTPMail(user.getEmail());

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

		} else if (controller.equals("/app") && (controllerSuffix.equals("/login") || controllerSuffix.equals("/signup")
				|| controllerSuffix.equals("/verification"))) {

			chain.doFilter(req, res);

		} else if (session.getAttribute("user") == null) {

			session.invalidate();
			req.getSession(true).setAttribute("error", "The Session has expired. Login again to access the bank");
			res.sendRedirect(contextPath + "/login");

		} else {
			chain.doFilter(req, res);
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
