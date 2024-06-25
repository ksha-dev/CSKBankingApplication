package com.cskbank.utility;
//

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;

import com.zoho.logs.logclient.v2.LogAPI;
import com.zoho.logs.logclient.v2.json.ZLMap;

//import org.apache.logging.log4j.LogManager;
//import org.apache.logging.log4j.Logger;
//
//public class LogUtil {
//
//	private static Logger logger = LogManager.getLogger("TestLogger");
//
//	public static void main(String[] args) {
//		logger.info("Hello");
//	}
//}

public class LogUtil {

	public synchronized static void logException(Throwable e) {
		StringWriter sw = new StringWriter();
		PrintWriter pw = new PrintWriter(sw);

		e.printStackTrace(pw);
		Throwable cause = e.getCause();
		if (cause != null) {
			cause.printStackTrace(pw);
		}
		try {
			LogAPI.log("access", new ZLMap().put("message", e.getMessage()).put("stacktrace", sw.toString()));
		} catch (IOException e1) {
			e.printStackTrace();
		}
	}

	public static void logString(String string) {
		try {
			LogAPI.log("access", new ZLMap().put("custom_print", string));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void logmickey(String string) {
		try {
			LogAPI.log("mickey", new ZLMap().put("custom_print", string));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}