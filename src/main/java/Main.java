//import java.io.BufferedReader;
//import java.io.BufferedWriter;
//import java.io.FileReader;
//import java.io.FileWriter;
//import java.io.IOException;
//import java.util.Properties;
//

import com.cskbank.consoleRunner.AppRunner;
import com.cskbank.exceptions.AppException;
import com.cskbank.servlet.Services;

public class Main {
	public static void main(String[] args) throws AppException {
		Services.initialize();
		AppRunner.runConsoleApp();
	}
}
//
////	public static void main(String[] args) throws Exception {
////		Properties props = new Properties();
////		props.setProperty("url", "url1");
////		props.setProperty("userName", "1");
////		props.setProperty("password", "password");
////		System.out.println(System.getProperty("user.dir"));
////		storeProperties(props);
////	}
//
//	public static void main(String[] args) throws Exception {
//		Properties props = getPropertiesFromFile(System.getProperty("user.dir") + "/properties",
//				"validation_redirect_url");
//		props.forEach((k, v) -> System.out.println(k + " : " + v));
//	}
//
////	public static void main(String[] args) {
////		System.out.println(Integer.MAX_VALUE);
////		try {
////			System.out.println(Long.parseLong("12345678901234567890"));
////		} catch (Exception e) {
////			System.out.println(e);
////		}
////	}
//
//	public static void storeProperties(Properties properties) throws Exception {
//		try (BufferedWriter writer = new BufferedWriter(new FileWriter("properties.txt"))) {
//			properties.store(writer, null);
//		} catch (IOException e) {
//			throw new Exception(e.getMessage());
//		}
//	}
//
//	public static Properties getPropertiesFromFile(String path, String fileName) throws Exception {
//		Properties returnProps = new Properties();
//		try (BufferedReader reader = new BufferedReader(new FileReader(path + "/" + fileName + ".properties"))) {
//			returnProps.load(reader);
//		} catch (IOException e) {
//			throw new Exception(e.getMessage());
//		}
//		return returnProps;
//	}
//}
