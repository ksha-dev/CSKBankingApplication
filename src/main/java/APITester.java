import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.net.ssl.HttpsURLConnection;

import org.json.JSONObject;

public class APITester {

	private static final String HTTP_URL = "http://localhost:8081/api/";
	private static final String HTTPS_URL = "https://localhost:8443/api/";

	public static void main(String[] args) {
		System.out.println(customerGetRequest(5));
		System.out.println(loginPostRequest(1, "Admin@2024"));
	}

	public static String customerGetRequest(int customerId) {
		StringBuilder response = new StringBuilder();
		try {
			URL url = new URL(HTTP_URL + "customer/" + customerId);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setRequestMethod("GET");
			connection.setRequestProperty("authentication", "Pq1M2GW1M1vcCV11FaUIXNs5HUlIrAOSn592iLEK");
			try (BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()))) {
				String line;
				while ((line = reader.readLine()) != null) {
					response.append(line);
					System.out.println(line);
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
			URL url = new URL(HTTP_URL + "login");
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

	public static void loginHttpsPostRequest(String[] args) {
		try {
			HttpsURLConnection connection = (HttpsURLConnection) new URL(HTTPS_URL).openConnection();

			connection.setRequestMethod("POST");
			connection.setRequestProperty("Content-Type", "application/json");
			connection.setRequestProperty("authentication", "Pq1M2GW1M1vcCV11FaUIXNs5HUlIrAOSn592iLEK");
			connection.setDoOutput(true);

			OutputStream os = connection.getOutputStream();
			OutputStreamWriter osw = new OutputStreamWriter(os, "UTF-8");

//			// Write JSON payload to output stream
//			osw.write(jsonInputString);
//			osw.flush();
//			osw.close();
//			os.close();

			// Check response code
			int responseCode = connection.getResponseCode();
			System.out.println("Response Code: " + responseCode);
			connection.disconnect();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
