package com.cskbank.filters;

import java.io.IOException;
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

import org.json.JSONObject;

import com.cskbank.exceptions.AppException;
import com.cskbank.servlet.HandlerObject;

/**
 * Servlet Filter implementation class SessionFilter
 */
@WebFilter("/APIAuthenticationFilter")
public class APIAuthenticationFilter implements Filter {

	/**
	 * Default constructor.
	 */
	public APIAuthenticationFilter() {
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

		System.out.println("API Key Filter : " + req.getRequestURL());

		String apiKey = req.getHeader("authentication");
		JSONObject responseContent = new JSONObject();
		if (!Objects.isNull(apiKey)) {
			try {
				HandlerObject.getCommonHandler().validateAPIKey(apiKey);
				chain.doFilter(req, res);
			} catch (AppException e) {
				responseContent.accumulate("status", "error");
				responseContent.accumulate("message", e.getMessage());
				res.getWriter().write(responseContent.toString());
			}
		} else {
			responseContent.accumulate("status", "error");
			responseContent.accumulate("message", "Invalid Authentication Parameters");
			res.getWriter().write(responseContent.toString());
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
