package com.cskbank.test;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.core.config.LoggerConfig;

public class Log4jTest {

	public static void main(String[] args) {
		LoggerConfig conf = new LoggerConfig.RootLogger();
		Logger logger = LogManager.getLogger(conf);
	}
}
