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

import com.cskbank.cache.CachePool;
import com.cskbank.exceptions.AppException;
import com.cskbank.exceptions.SessionFilterException;
import com.cskbank.modules.UserRecord;
import com.cskbank.servlet.HandlerObject;
import com.cskbank.utility.ConstantsUtil.Status;
import com.cskbank.utility.ServletUtil;

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
	public SessionFilter() {
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

		try {
			sessionCheck(req);
			rootControllerCheck(req);
			appControllerCheck(req);
		} catch (SessionFilterException e) {
			if (e.isErrorAvailable()) {
				req.getSession().setAttribute("error", e.getMessage());
			}

			if (e.isRedirect()) {
				res.sendRedirect(e.getURL());
			} else {
				req.getRequestDispatcher(e.getURL()).forward(req, res);
			}
			return;
		}
		chain.doFilter(req, res);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

	public void sessionCheck(HttpServletRequest request) throws IOException, SessionFilterException {
		if (request.getSession(false) == null) {
			throw new SessionFilterException("Session Expired", ServletUtil.getRedirectContextURL(request, "login"),
					true);
		}
	}

	public void appPathCheck(HttpServletRequest request) throws SessionFilterException, ServletException, IOException {
		UserRecord user = ServletUtil.getUser(request);
		String path = request.getPathInfo();

		if (!path.startsWith("/" + user.getType().toString().toLowerCase() + "/")) {
			throw new SessionFilterException(ServletUtil.getRedirectContextURL(request,
					"app/" + user.getType().toString().toLowerCase() + "/home"), true);
		}
	}

	public void userObjectCheck(HttpServletRequest request)
			throws SessionFilterException, IOException, ServletException {
		UserRecord user = ServletUtil.getUser(request);
		UserRecord updatedUser = null;

		if (user == null) {
			throw new SessionFilterException("User not found. Please login again",
					ServletUtil.getLoginRedirect(request), true);
		}

		if (request.getServletPath().equals("/app")
				&& request.getPathInfo().equals("/" + user.getType().toString().toLowerCase() + "/logout")) {
			request.getSession(false).invalidate();
			throw new SessionFilterException("User has been logged out", ServletUtil.getLoginRedirect(request), true);
		}

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
			throw new SessionFilterException("User integrity check failed", ServletUtil.getLoginRedirect(request),
					true);
		}

		if (unverifiedUser.getStatus() == Status.BLOCKED) {
			request.getSession(false).removeAttribute("unverified_user");
			throw new SessionFilterException("/WEB-INF/jsp/common/blocked.jsp", false);
		}

		if (unverifiedUser.getStatus() != Status.VERIFICATION) {
			request.getSession(false).removeAttribute("unverified_user");
			throw new SessionFilterException("Verification not required", ServletUtil.getLoginRedirect(request), true);
		}

		ServletUtil.session(request).setAttribute("unverified_user", updatedUser);
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
		case "resend":
			verificationCheck(request);
			throw new SessionFilterException(ServletUtil.getRedirectContextURL(request, "app/" + controller), true);

		case "reset_password":
		case "login":
		case "signup": {
			if (unverifiedUser != null) {
				session.removeAttribute("unverified_user");
			}
			if (user != null) {
				userObjectCheck(request);
				throw new SessionFilterException(ServletUtil.getRedirectContextURL(request,
						"app/" + user.getType().toString().toLowerCase() + "/home"), true);
			} else {
				throw new SessionFilterException("/WEB-INF/jsp/common/" + controller + ".jsp", false);
			}
		}

		}
	}

	public void verificationCheck(HttpServletRequest request)
			throws SessionFilterException, ServletException, IOException {
		UserRecord user = ServletUtil.getUser(request);
		UserRecord unverifiedUser = ServletUtil.getUnverifiedUser(request);
		if (unverifiedUser == null && user == null) {
			throw new SessionFilterException("Invalid verification", ServletUtil.getLoginRedirect(request), true);
		}
		if (user != null && unverifiedUser == null) {
			throw new SessionFilterException("No verification user found", ServletUtil.getRedirectContextURL(request,
					"app/" + user.getType().toString().toLowerCase() + "/home"), true);
		}
		if (user != null && unverifiedUser != null) {
			ServletUtil.session(request).invalidate();
			throw new SessionFilterException("Invalid session obtained", ServletUtil.getLoginRedirect(request), true);
		}
		unverifiedObjectCheck(request);
	}

	public void appControllerCheck(HttpServletRequest request)
			throws SessionFilterException, ServletException, IOException {
		String servlet = request.getServletPath();
		String path = request.getPathInfo();

		if (servlet.equals("/app")) {
			if (path == null || path == "/") {
				throw new SessionFilterException(ServletUtil.getLoginRedirect(request), true);
			}
			switch (path) {
			case "/verification":
			case "/resend":
				verificationCheck(request);
				break;

			case "/reset_password":
			case "/login":
			case "/signup":
			case "/rp":
			case "/complete_reset_password":
				break;

			default:
				userObjectCheck(request);
				appPathCheck(request);
			}
		}
	}

}
