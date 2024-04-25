package filters;

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

		String url = req.getServletPath();
		System.out.println("REQUEST FILTER : " + url);

		if (url.equals("/index.html")) {
			req.getRequestDispatcher("index.html").forward(req, res);

		} else if (url.equals("/login")) {
			req.getRequestDispatcher("/WEB-INF/jsp/common/login.jsp").forward(req, res);

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
