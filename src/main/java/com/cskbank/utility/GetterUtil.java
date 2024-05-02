package com.cskbank.utility;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

import com.cskbank.exceptions.AppException;

public class GetterUtil {

	public static Properties getPropertiesFromFile(String path, String fileName) throws AppException {
		Properties returnProps = new Properties();
		try (BufferedReader reader = new BufferedReader(new FileReader(path + "/" + fileName))) {
			returnProps.load(reader);
			return returnProps;
		} catch (IOException e) {
			throw new AppException("Cannot load Properties");
		}
	}

	public static Properties getRedirectProperties() throws AppException {
		return getPropertiesFromFile(System.getProperty("project.location") + "/properties", "redirects.properties");
	}
}
