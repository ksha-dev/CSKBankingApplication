package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.google.gson.JsonObject;

import exceptions.AppException;
import handlers.CommonHandler;
import modules.UserRecord;

public class APIServlet extends HttpServlet {

//	public void service(HttpServletRequest request, HttpServletResponse response) throws IOException {
//		System.out.println(request.getRequestURL());
//
//		JSONObject json = new JSONObject();
//		json.append("status", "Request Success");
//
//		PrintWriter pw = response.getWriter();
//		pw.write(json.toString());
//	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		JsonObject json = new JsonObject();

		for (String name : request.getParameterMap().keySet()) {
			System.out.println(name);
			json.addProperty(name, request.getParameter(name));
		}
		CommonServletHelper servlet = new CommonServletHelper();
		try {
			UserRecord user = servlet.loginPostRequest(request, response);
			response.getWriter().print(user);
		} catch (AppException | ServletException | IOException e) {
			e.printStackTrace();
		}
	}
}
