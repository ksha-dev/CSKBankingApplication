package filters;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Objects;

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

import exceptions.AppException;
import modules.UserRecord;
import utility.ConvertorUtil;
import utility.ServletUtil;
import utility.ValidatorUtil;

/**
 * Servlet Filter implementation class ValidationFilter
 */
@WebFilter("/ValidationFilter")
public class ValidationFilter implements Filter {

	/**
	 * Default constructor.
	 */
	public ValidationFilter() {
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

		String servletPath = req.getServletPath();
		String pathInfo = req.getPathInfo();
		Map<String, String[]> parameters = req.getParameterMap();

		if (servletPath.equals("/app")) {
			try {
				if (pathInfo.endsWith("/statement")) {
					if (req.getMethod().equals("POST")) {
						ServletUtil.checkRequiredParameters(parameters, List.of(Parameters.ACCOUNTNUMBER,
								Parameters.TRANSACTIONLIMIT, Parameters.PAGECOUNT, Parameters.CURRENTPAGE));
						if (parameters.get(Parameters.TRANSACTIONLIMIT.parameterName())[0].equals("custom")) {
							ServletUtil.checkRequiredParameters(parameters,
									List.of(Parameters.STARTDATE, Parameters.ENDDATE));
						}
					}
					chain.doFilter(req, res);
				} else {
					switch (pathInfo) {
					case "/login":
						ServletUtil.checkRequiredParameters(parameters,
								List.of(Parameters.USERID, Parameters.PASSWORD));
						break;

					case "/employee/account_details":
					case "/customer/account_details":
					case "/admin/account_details":
						ServletUtil.checkRequiredParameters(parameters, List.of(Parameters.ACCOUNTNUMBER));
						break;

					case "/employee/branch_accounts":
					case "/admin/accounts":
					case "/admin/employees":
					case "/admin/branches":
						if (req.getMethod().equals("POST")) {
							ServletUtil.checkRequiredParameters(parameters,
									List.of(Parameters.PAGECOUNT, Parameters.CURRENTPAGE));
						}
						break;

					case "/employee/search":
					case "/admin/search":
						if (req.getMethod().equals("POST")) {
							ServletUtil.checkRequiredParameters(parameters,
									List.of(Parameters.SEARCHBY, Parameters.SEARCHVALUE));
						}
						break;

					case "/employee/authorization":
					case "/admin/authorization":
					case "/customer/authorization":
						ServletUtil.commonAuthorizationCheck(parameters);
						break;

					case "/admin/employee_details":
						ServletUtil.checkRequiredParameters(parameters, List.of(Parameters.USERID));
						break;

					}
					chain.doFilter(req, res);
				}
			} catch (AppException e) {
				req.setAttribute("status", false);
				req.setAttribute("message", e.getMessage());
				req.setAttribute("redirect", "back");
				req.getRequestDispatcher("/WEB-INF/jsp/common/transaction_status.jsp").forward(request, response);
			}
		} else {
			req.getRequestDispatcher("/static/html/page_not_found.html").forward(request, response);
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
