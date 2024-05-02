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

import com.cskbank.modules.UserRecord;

/**
 * Servlet Filter implementation class SessionFilter
 */
@WebFilter("/SessionFilter")
public class SessionFilter implements Filter {

	/**
	 * Default constructor.
	 */
	public SessionFilter() {
		// TODO Auto-generated constructor stub
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

		HttpSession session = req.getSession();

		if (req.getServletPath().equals("/login")) {
			UserRecord user = (UserRecord) session.getAttribute("user");
			if (user != null) {
				res.sendRedirect("app/" + user.getType().toString().toLowerCase() + "/home");
			} else {
				req.getRequestDispatcher("/WEB-INF/jsp/common/login.jsp").forward(req, res);
			}
		} else if (req.getPathInfo() == null) {
			res.sendRedirect(req.getContextPath() + "/login");
		} else if (req.getPathInfo().endsWith("/logout")) {
			session.invalidate();
			req.getSession(true).setAttribute("error", "User has been logged out");
			res.sendRedirect(req.getContextPath() + "/login");

		} else if (req.getServletPath().equals("/app") && req.getPathInfo().equals("/login")) {

			chain.doFilter(req, res);

		} else if (session == null) {

			req.getSession(true).setAttribute("error", "The Session has expired. Login again to access the bank");
			res.sendRedirect(req.getContextPath() + "/login");

		} else if (session.getAttribute("user") == null) {

			session.invalidate();
			req.getSession(true).setAttribute("error", "The Session has expired. Login again to access the bank");
			res.sendRedirect(req.getContextPath() + "/login");

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
