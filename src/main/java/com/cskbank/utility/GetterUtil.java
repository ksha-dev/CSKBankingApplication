package com.cskbank.utility;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;
import java.util.concurrent.ThreadLocalRandom;

import com.cskbank.exceptions.AppException;

public class GetterUtil {

	private static Properties redirectURLProperties = null;

	public static Properties getProperties(String path, String fileName) throws AppException {
		Properties returnProps = new Properties();
		try (BufferedReader reader = new BufferedReader(new FileReader(path + "/" + fileName))) {
			returnProps.load(reader);
			return returnProps;
		} catch (IOException e) {
			throw new AppException("Cannot load Properties");
		}
	}

	public static void loadRedirectURLProperties() throws AppException {
		redirectURLProperties = getProperties(System.getProperty("project.location") + "/properties",
				"redirects.properties");
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
}
