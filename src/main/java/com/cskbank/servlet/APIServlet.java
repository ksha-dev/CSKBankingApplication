package com.cskbank.servlet;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.cskbank.exceptions.AppException;
import com.cskbank.modules.CustomerRecord;
import com.cskbank.modules.EmployeeRecord;
import com.cskbank.utility.ConstantsUtil.RequestStatus;

public class APIServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPut(HttpServletRequest request, HttpServletResponse response) throws IOException {
		JSONObject responseContent = new JSONObject();
		RequestStatus status = null;
		String path = request.getPathInfo();
		try {
			switch (path) {
			case "/branch":
				responseContent.accumulate("data", JSONObject.wrap(APIServletHandler.createBranch(request, response)));
				status = RequestStatus.SUCCESS;
				break;

			default:
				responseContent.accumulate("message", "Invalid API Request");
				status = RequestStatus.FAILED;
				break;
			}
		} catch (Exception e) {
			status = RequestStatus.FAILED;
			responseContent.accumulate("message", e.getMessage());
			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
		}
		responseContent.accumulate("status", status.toString());
		response.getWriter().write(responseContent.toString());
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String path = request.getPathInfo();
		System.out.println(path);
		JSONObject responseContent = new JSONObject();
		RequestStatus status = null;
		try {
			switch (path) {

			case "/login":
				responseContent.accumulate("data", JSONObject.wrap(APIServletHandler.login(request, response)));
				status = RequestStatus.SUCCESS;
				break;

			default:
				responseContent.accumulate("message", "Invalid API Request");
				status = RequestStatus.FAILED;
				break;
			}

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
			if (apiPath == null) {
				response.getWriter().write("Welcome to CSK Banking Application REST API");
				return;
			}
			String[] apiPaths = apiPath.split("/");

			switch (apiPaths[1]) {
			case "customer":
				CustomerRecord customer = HandlerObject.getCustomerHandler()
						.getCustomerRecord(Integer.parseInt(apiPaths[2]));
				result.accumulate("data", JSONObject.wrap(customer));
				status = RequestStatus.SUCCESS;
				break;

			case "employee":
				EmployeeRecord employee = HandlerObject.getEmployeeHandler()
						.getEmployeeRecord(Integer.parseInt(apiPaths[2]));
				result.accumulate("data", JSONObject.wrap(employee));
				status = RequestStatus.SUCCESS;

			default:
				result.accumulate("message", "Invalid API Request");
				status = RequestStatus.FAILED;
				break;
			}
		} catch (AppException e) {
			result.accumulate("message", e.getMessage());
			status = RequestStatus.FAILED;
		}
		result.accumulate("status", status.toString());
		response.getWriter().write(result.toString());
	}

}
