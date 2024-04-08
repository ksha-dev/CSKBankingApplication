package servlet;

import java.io.IOException;
import java.util.Objects;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import exceptions.AppException;

/**
 * Servlet Filter implementation class FilterServlet
 */
@WebFilter("/FilterServlet")
public class RequestFilter implements Filter {

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

		String path = req.getPathInfo();
		String servletPath = req.getServletPath();

		if (servletPath.startsWith("/static") || servletPath.equals("/index.html")) {
			chain.doFilter(req, res);
		} else if (servletPath.equals("/app") && path.equals("/login")) {
			ServletUtil.dispatchRequest(req, res, servletPath + (Objects.isNull(path) ? "" : path));
		} else if (servletPath.equals("/app")) {
			HttpSession session = ServletUtil.session(req);
			if (Objects.isNull(session) || Objects.isNull(session.getAttribute("user"))) {
				res.sendRedirect(req.getContextPath() + "/app/login");
			} else {
				ServletUtil.dispatchRequest(req, res, servletPath + (Objects.isNull(path) ? "" : path));
			}
		} else {
			ServletUtil.dispatchRequest(req, res, "/static/html/page_not_found.html");
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
