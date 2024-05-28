package com.cskbank.filters;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cskbank.exceptions.AppException;
import com.cskbank.utility.GetterUtil;
import com.cskbank.utility.ServletUtil;

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
								List.of(Parameters.USERID, Parameters.PASSWORD, Parameters.RECAPTCHA_RESPONSE));
						break;

					case "/signup":
						ServletUtil.checkRequiredParameters(parameters,
								List.of(Parameters.FIRSTNAME, Parameters.LASTNAME, Parameters.DATEOFBIRTH,
										Parameters.GENDER, Parameters.ADDRESS, Parameters.PHONE, Parameters.EMAIL,
										Parameters.AADHAAR, Parameters.PAN, Parameters.RECAPTCHA_RESPONSE));
						break;

					case "/verification":
						if (req.getMethod().equals("POST")) {
							ServletUtil.checkRequiredParameters(parameters, List.of(Parameters.OTP));
						}
						break;

					case "/reset_password":
						if (req.getMethod().equals("POST")) {
							ServletUtil.checkRequiredParameters(parameters,
									List.of(Parameters.USERID, Parameters.EMAIL));
						}
						break;

					case "/rp":
						ServletUtil.checkRequiredParameters(parameters, List.of(Parameters.ID));
						break;

					case "/complete_reset_password":
						if (req.getMethod().equals("POST")) {
							ServletUtil.checkRequiredParameters(parameters,
									List.of(Parameters.NEWPASSWORD, Parameters.CONFIRM_PASSWORD, Parameters.ID));
						}
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
					case "/admin/api_service":
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

					case "/customer/authorization":
						if (req.getMethod().equals("POST"))
							ServletUtil.commonAuthorizationCheck(parameters);
						break;

					case "/admin/authorization":
						if (req.getMethod().equals("POST")) {
							ServletUtil.commonAuthorizationCheck(parameters);
							String operation = parameters.get(Parameters.OPERATION.parameterName())[0];
							switch (operation) {
							case "authorize_add_employee":
								ServletUtil.checkRequiredParameters(parameters,
										List.of(Parameters.FIRSTNAME, Parameters.LASTNAME, Parameters.DATEOFBIRTH,
												Parameters.GENDER, Parameters.ADDRESS, Parameters.PHONE,
												Parameters.EMAIL, Parameters.ROLE, Parameters.BRANCHID));
								break;

							case "authorize_add_branch":
								ServletUtil.checkRequiredParameters(parameters,
										List.of(Parameters.ADDRESS, Parameters.PHONE, Parameters.EMAIL));
								break;

							case "authorize_change_status":
								ServletUtil.checkRequiredParameters(parameters,
										List.of(Parameters.STATUS, Parameters.REASON, Parameters.USERID));
								break;
							}
						}
					case "/employee/authorization": {
						if (req.getMethod().equals("POST")) {
							ServletUtil.commonAuthorizationCheck(parameters);
							String operation = parameters.get(Parameters.OPERATION.parameterName())[0];
							switch (operation) {
							case "authorize_transaction":
								ServletUtil.checkRequiredParameters(parameters,
										List.of(Parameters.ACCOUNTNUMBER, Parameters.AMOUNT, Parameters.TYPE));
								break;

							case "authorize_open_account":
								ServletUtil.checkRequiredParameters(parameters,
										List.of(Parameters.TYPE, Parameters.AMOUNT, Parameters.CUSTOMERTYPE));
								switch (request.getParameter(Parameters.CUSTOMERTYPE.parameterName())) {
								case "new":
									ServletUtil.checkRequiredParameters(parameters,
											List.of(Parameters.FIRSTNAME, Parameters.LASTNAME, Parameters.DATEOFBIRTH,
													Parameters.GENDER, Parameters.ADDRESS, Parameters.PHONE,
													Parameters.EMAIL, Parameters.AADHAAR, Parameters.PAN));
									break;

								case "existing":
									ServletUtil.checkRequiredParameters(parameters, List.of(Parameters.USERID));
									break;

								default:
									throw new AppException("Invalid Customer Type obtained");
								}
								break;

							case "authorize_freeze_account":
							case "authorize_close_account":
								ServletUtil.checkRequiredParameters(parameters, List.of(Parameters.ACCOUNTNUMBER));
								break;
							}
						}
					}
						break;

					case "/admin/employee_details":
						ServletUtil.checkRequiredParameters(parameters, List.of(Parameters.USERID));
						break;

					case "/admin/create_api_key":
						ServletUtil.checkRequiredParameters(parameters, List.of(Parameters.ORGNAME));
						break;

					case "/admin/invalidate_api_key":
						ServletUtil.checkRequiredParameters(parameters, List.of(Parameters.AKID));
						break;

					}
					chain.doFilter(req, res);
				}
			} catch (AppException e) {
				ServletUtil.redirectError(req, res, e);
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
