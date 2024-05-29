package com.cskbank.filters;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.Level;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.cskbank.exceptions.AppException;
import com.cskbank.modules.UserRecord;

/**
 * Servlet Filter implementation class FilterServlet
 */
@WebFilter("/FilterServlet")
public class RequestFilter implements Filter {

	private static Logger requestLogger = LogManager.getLogger(RequestFilter.class);

	/**
	 * Default constructor.
	 * 
	 * @throws AppException
	 */
	public RequestFilter() {

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

		res.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
		res.setHeader("pragma", "no-cache");
		res.setHeader("Expires", "0");

		String url = req.getServletPath();
		if (!url.startsWith("/static")) {
			requestLogger.log(Level.INFO, String.format("%s | %s | %s | %s", req.getRemoteHost(), req.getMethod(),
					req.getServletPath(), req.getPathInfo()));

		}

		if (url.equals("/index.html")) {
			req.getRequestDispatcher("index.html").forward(req, res);

		} else if (url.equals("/login") || url.equals("/signup") || url.equals("/reset_password")) {
			chain.doFilter(req, res);

		} else if (url.equals("/verification") && (req.getPathInfo() == null || req.getPathInfo() == "/resend")) {
			chain.doFilter(req, res);

		} else if (url.startsWith("/static")) {
			req.getRequestDispatcher(url).forward(req, res);

		} else if (url.equals("/app") || url.equals("/api")) {
			chain.doFilter(req, res);

		} else {
			req.getRequestDispatcher("/static/html/page_not_found.html").forward(req, res);
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
