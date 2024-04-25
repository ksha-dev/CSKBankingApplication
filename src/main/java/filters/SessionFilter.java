package filters;

import java.io.IOException;
import java.util.Enumeration;
import java.util.Iterator;

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

import org.json.JSONObject;

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

		HttpSession session = req.getSession(false);
		String url = req.getServletPath();

		System.out.println("SESSION FILTER : " + url);
		if (url.equals("/api")) {
			String path = req.getPathInfo();
			if (!path.equals("/generateKey")) {
				Iterator<String> headers = req.getHeaderNames().asIterator();
				boolean apiKeyFound = false;
				while (!apiKeyFound && headers.hasNext()) {
					String key = headers.next();
					if (key.startsWith("CSKB")) {
						apiKeyFound = true;
					}
				}

				if (apiKeyFound) {
					req.getRequestDispatcher("/api" + (path == null ? "" : path)).forward(req, res);
				} else {
					JSONObject responseContent = new JSONObject();
					responseContent.accumulate("status", "unauthorized");
					responseContent.accumulate("message", "Invalid authentication parameters");
					res.getWriter().write(responseContent.toString());
				}
			}

		} else if (url.equals("/app")) {
			if (req.getPathInfo() == null) {
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
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
