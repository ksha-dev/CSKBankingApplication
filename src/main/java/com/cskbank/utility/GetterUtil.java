package com.cskbank.utility;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.util.concurrent.ThreadLocalRandom;

import com.cskbank.exceptions.AppException;

public class GetterUtil {

	private static Properties redirectURLProperties = null;

	public static Properties loadPropertiesFile(String propertiesFileName) throws AppException {
		Properties properties = new Properties();
		try (InputStream input = GetterUtil.class.getClassLoader().getResourceAsStream(propertiesFileName)) {
			if (input == null) {
				throw new AppException("Unable to load " + propertiesFileName);
			}
			properties.load(input);
			return properties;
		} catch (IOException ex) {
			ex.printStackTrace();
			throw new AppException("Cannot load Properties");
		}
	}

	public synchronized static void loadRedirectURLProperties() throws AppException {
		if (redirectURLProperties == null) {
			redirectURLProperties = loadPropertiesFile("redirects.properties");
		}
	}

	public static String getRedirectURL(String requestURL) {
		if (requestURL == null) {
			return "/login";
		} else {
			return redirectURLProperties.getProperty(requestURL, "/login");
		}
	}

	public static String getIfscCode(int branchId) throws AppException {
		ValidatorUtil.validateId(branchId);
		return String.format("CSKB0%06d", branchId);
	}

	public static int getOTP() {
		return ThreadLocalRandom.current().nextInt(111111, 999999);
	}

	public static int getPageCount(int count) {
		int pageCount = 0;
		if (count % ConstantsUtil.LIST_LIMIT == 0) {
			pageCount = count / ConstantsUtil.LIST_LIMIT;
		} else {
			pageCount = count / ConstantsUtil.LIST_LIMIT + 1;
		}
		return pageCount > ConstantsUtil.MAX_PAGE_COUNT ? ConstantsUtil.MAX_PAGE_COUNT : pageCount;
	}
}
