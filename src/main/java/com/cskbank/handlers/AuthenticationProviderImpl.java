package com.cskbank.handlers;

import java.io.IOException;

import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.adventnet.iam.security.DefaultAuthenticationProviderImpl;
import com.adventnet.iam.security.SecurityFilterProperties;

public class AuthenticationProviderImpl extends DefaultAuthenticationProviderImpl {

	private static Logger logger = LogManager.getRootLogger();

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		super.init(filterConfig);
		logger.info("Custom Authentication Filter : " + filterConfig.getFilterName());
	}

	@Override
	public void init(SecurityFilterProperties secFilterProps) throws ServletException {
		// TODO Auto-generated method stub
		super.init(secFilterProps);
		logger.info("Custom Authentication SecurityFilter : " + secFilterProps.getCaptchaUrl());
	}

	@Override
	public boolean authenticate(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String getRemoteAddr(HttpServletRequest request, String remoteIp) {
		// TODO Auto-generated method stub
		return super.getRemoteAddr(request, remoteIp);
	}

}
