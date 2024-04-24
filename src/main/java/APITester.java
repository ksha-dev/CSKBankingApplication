import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.net.ssl.HttpsURLConnection;

import org.json.JSONObject;

public class APITester {

	private static final String URL = "http://localhost:8081/CSKBankingApplication/api/";

	public static void main(String[] args) {
		System.out.println(System.getProperty("user.dir"));
		System.out.println(customerGetRequest(5));
//		System.out.println(loginPostRequest(1, "Admin@2024"));
//		System.out.println(loginPostRequest(2, "Sharan@1224"));
	}

	public static String customerGetRequest(int customerId) {
		StringBuilder response = new StringBuilder();
		try {
			URL url = new URL(URL + "customer/" + customerId);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setRequestMethod("GET");
			try (BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()))) {
				String line;
				while ((line = reader.readLine()) != null) {
					response.append(line);
				}
			}
			connection.disconnect();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return response.toString();
	}

	public static String loginPostRequest(int userId, String password) {
		JSONObject requestBody = new JSONObject();
		requestBody.accumulate("userId", userId);
		requestBody.accumulate("password", password);

		StringBuilder response = new StringBuilder();
		try {
			URL url = new URL(URL + "login");
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setRequestMethod("POST");
			connection.setRequestProperty("Content-Type", "application/json");
			connection.setDoOutput(true);

			try (OutputStream os = connection.getOutputStream()) {
				os.write(requestBody.toString().getBytes());
			}

			try (BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()))) {
				String line;
				while ((line = reader.readLine()) != null) {
					response.append(line);
				}
			}
			connection.disconnect();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return response.toString();
	}
}
