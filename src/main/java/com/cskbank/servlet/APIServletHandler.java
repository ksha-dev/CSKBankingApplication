package com.cskbank.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.net.http.HttpRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.cskbank.exceptions.AppException;
import com.cskbank.exceptions.messages.ActivityExceptionMessages;
import com.cskbank.modules.Branch;
import com.cskbank.modules.EmployeeRecord;
import com.cskbank.modules.UserRecord;
import com.cskbank.modules.UserRecord.Type;
import com.cskbank.utility.ConstantsUtil.RequestStatus;

public class APIServletHandler {

	public static Branch createBranch(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException {
		JSONObject requestBody = getRequestBody(request);
		Branch createBranch = new Branch();
		createBranch.setAddress(requestBody.getString("address"));
		createBranch.setPhone(requestBody.getLong("phone"));
		createBranch.setEmail(requestBody.getString("email"));
		EmployeeRecord admin = HandlerObject.adminHandler.getEmployeeDetails(requestBody.getInt("adminId"));
		if (admin.getType() != UserRecord.Type.ADMIN) {
			throw new AppException(ActivityExceptionMessages.USER_AUTHORIZATION_FAILED);
		}
		return HandlerObject.adminHandler.createBranch(createBranch, requestBody.getInt("adminId"),
				requestBody.getString("pin"));
	}

	public static UserRecord login(HttpServletRequest request, HttpServletResponse response)
			throws JSONException, AppException, IOException {
		JSONObject requestBody = getRequestBody(request);
		int userId = requestBody.getInt("userId");
		return HandlerObject.commonHandler.getUser(userId, requestBody.getString("password"));
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
