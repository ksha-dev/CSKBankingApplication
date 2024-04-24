package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.google.gson.JsonObject;

import exceptions.AppException;
import exceptions.messages.APIExceptionMessage;
import exceptions.messages.ActivityExceptionMessages;
import handlers.CommonHandler;
import modules.Branch;
import modules.CustomerRecord;
import modules.EmployeeRecord;
import modules.UserRecord;
import utility.ConstantsUtil.RequestStatus;
import utility.ConstantsUtil.Status;
import utility.ConstantsUtil.UserType;

public class APIServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public APIServlet() throws AppException {
		Services.initialize();
	}

	public void doPut(HttpServletRequest request, HttpServletResponse response) throws IOException {
		JSONObject requestBody = getRequestBody(request);
		JSONObject responseContent = new JSONObject();
		RequestStatus status = null;
		System.out.println(requestBody.toString());
		try {
			Branch createBranch = new Branch();
			createBranch.setAddress(requestBody.getString("address"));
			createBranch.setPhone(requestBody.getLong("phone"));
			createBranch.setEmail(requestBody.getString("email"));
			EmployeeRecord admin = Services.adminOperations.getEmployeeDetails(requestBody.getInt("adminId"));
			if (admin.getType() != UserType.ADMIN) {
				throw new AppException(ActivityExceptionMessages.USER_AUTHORIZATION_FAILED);
			}
			Branch createdBranch = Services.adminOperations.createBranch(createBranch, requestBody.getInt("adminId"),
					requestBody.getString("pin"));
			status = RequestStatus.SUCCESS;
			responseContent.accumulate("data", JSONObject.wrap(createdBranch));
		} catch (Exception e) {
			status = RequestStatus.FAILED;
			responseContent.accumulate("message", e.getMessage());
			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
		}
		responseContent.accumulate("status", status.toString());
		response.getWriter().write(responseContent.toString());
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		JSONObject requestBody = getRequestBody(request);
		JSONObject responseContent = new JSONObject();
		RequestStatus status = null;
		try {
			UserRecord user = Services.appOperations.getUser(requestBody.getInt("userId"),
					requestBody.getString("password"));
			responseContent.accumulate("data", JSONObject.wrap(user));
			status = RequestStatus.SUCCESS;
		} catch (AppException e) {
			responseContent.accumulate("message", e.getMessage());
			status = RequestStatus.FAILED;
		}
		responseContent.accumulate("status", status.toString());
		response.getWriter().write(responseContent.toString());
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		JSONObject result = new JSONObject();
		RequestStatus status = null;
		try {
			String apiPath = request.getPathInfo();
			System.out.println(apiPath);
			String[] apiPaths = apiPath.split("/");
			for (String path : apiPaths) {
				System.out.println(path);
			}

			switch (apiPaths[1]) {
			case "customer":
				CustomerRecord customer = Services.customerOperations.getCustomerRecord(Integer.parseInt(apiPaths[2]));
				result.accumulate("data", JSONObject.wrap(customer));
				status = RequestStatus.SUCCESS;
				break;

			case "employee":
				EmployeeRecord employee = Services.employeeOperations.getEmployeeRecord(Integer.parseInt(apiPaths[2]));
				result.accumulate("data", JSONObject.wrap(employee));
				status = RequestStatus.SUCCESS;
			default:
				break;
			}
		} catch (AppException e) {
			result.accumulate("message", e.getMessage());
			status = RequestStatus.FAILED;
		}
		result.accumulate("status", status.toString());
		response.getWriter().write(result.toString());
	}

	private JSONObject getRequestBody(HttpServletRequest request) throws IOException {
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
