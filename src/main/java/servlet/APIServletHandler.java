package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.net.http.HttpRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import exceptions.AppException;
import exceptions.messages.ActivityExceptionMessages;
import modules.Branch;
import modules.EmployeeRecord;
import modules.UserRecord;
import utility.ConstantsUtil.RequestStatus;
import utility.ConstantsUtil.UserType;

public class APIServletHandler {

	public static Branch createBranch(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException {
		JSONObject requestBody = getRequestBody(request);
		Branch createBranch = new Branch();
		createBranch.setAddress(requestBody.getString("address"));
		createBranch.setPhone(requestBody.getLong("phone"));
		createBranch.setEmail(requestBody.getString("email"));
		EmployeeRecord admin = Services.adminOperations.getEmployeeDetails(requestBody.getInt("adminId"));
		if (admin.getType() != UserType.ADMIN) {
			throw new AppException(ActivityExceptionMessages.USER_AUTHORIZATION_FAILED);
		}
		return Services.adminOperations.createBranch(createBranch, requestBody.getInt("adminId"),
				requestBody.getString("pin"));
	}

	public static UserRecord login(HttpServletRequest request, HttpServletResponse response)
			throws JSONException, AppException, IOException {
		JSONObject requestBody = getRequestBody(request);
		int userId = requestBody.getInt("userId");
		return Services.appOperations.getUser(userId, requestBody.getString("password"));
	}

	private static JSONObject getRequestBody(HttpServletRequest request) throws IOException {
		JSONObject requestBody = null;
		try (BufferedReader reader = request.getReader()) {
			StringBuilder requestStringBuilder = new StringBuilder();
			String line;
			while ((line = reader.readLine()) != null) {
				requestStringBuilder.append(line);
			}
			requestBody = new JSONObject(requestStringBuilder.toString());
		}
		return requestBody;
	}
}
