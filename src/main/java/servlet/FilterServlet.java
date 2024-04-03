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

/**
 * Servlet Filter implementation class FilterServlet
 */
@WebFilter("/FilterServlet")
public class FilterServlet implements Filter {

	/**
	 * Default constructor.
	 */
	public FilterServlet() {
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
		String path = req.getPathInfo();
		String servletPath = req.getServletPath();
		System.out.println(servletPath);
		if (servletPath.startsWith("/static") || servletPath.equals("/index.html")) {
			chain.doFilter(req, res);
		} else if (servletPath.startsWith("/app") && path.startsWith("/login")) {
			RequestDispatcher dispatcher = req.getRequestDispatcher(servletPath + (Objects.isNull(path) ? "" : path));
			dispatcher.forward(req, res);
		} else if (servletPath.startsWith("/app")) {
			HttpSession session = req.getSession(false);
			System.out.println(session);
			if (Objects.isNull(session) || Objects.isNull(session.getAttribute("user"))) {
				res.sendRedirect(req.getContextPath() + "/app/login");
			} else {
				RequestDispatcher dispatcher = req
						.getRequestDispatcher(servletPath + (Objects.isNull(path) ? "" : path));
				dispatcher.forward(req, res);
			}
		} else {
			RequestDispatcher dispatcher = req.getRequestDispatcher("/static/html/page_not_found.html");
			dispatcher.forward(req, res);
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
