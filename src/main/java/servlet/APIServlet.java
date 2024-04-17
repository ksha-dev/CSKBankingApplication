package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.google.gson.JsonObject;

public class APIServlet extends HttpServlet {

	public void service(HttpServletRequest request, HttpServletResponse response) throws IOException {

		JSONObject json = new JSONObject();
	}
}
