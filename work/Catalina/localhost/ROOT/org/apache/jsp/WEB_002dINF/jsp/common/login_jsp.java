/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.x-dev
 * Generated at: 2024-06-19 17:54:48 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.jsp.common;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import com.cskbank.filters.Parameters;
import java.util.Objects;

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.LinkedHashSet<>(3);
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.LinkedHashSet<>(2);
    _jspx_imports_classes.add("java.util.Objects");
    _jspx_imports_classes.add("com.cskbank.filters.Parameters");
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    if (!javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET, POST or HEAD. Jasper also permits OPTIONS");
        return;
      }
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");

response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
response.setHeader("pragma", "no-cache");
response.setHeader("Expires", "0");

      out.write("<head>\n");
      out.write("<meta charset=\"UTF-8\">\n");
      out.write("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("<title>Login | CSK Bank</title>\n");
      out.write("<link rel=\"stylesheet\" href=\"static/css/styles.css\">\n");
      out.write("<script src=\"static/script/script.js\"></script>\n");
      out.write("<script src=\"static/script/validator.js\"></script>\n");
      out.write("<script src=\"static/script/login.js\"></script>\n");
      out.write("<script\n");
      out.write("	src=\"https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js\"></script>\n");
      out.write("<script src=\"https://www.google.com/recaptcha/enterprise.js\" async defer></script>\n");
String error = (String) request.getSession(false).getAttribute("error");
if (error != null) {
	request.getSession(false).removeAttribute("error");
	out.print("<script>errorMessage('" + error + "')</script>");
}
      out.write("</head>\n");
      out.write("\n");
      out.write("<body class=\"login\">\n");
      out.write("	<div class=\"login-align\">\n");
      out.write("		<div class=\"login-container\">\n");
      out.write("			<h1 class=\"login-element\">Login</h1>\n");
      out.write("			<p class=\"login-element\" style=\"margin-bottom: 20px;\">Enter your\n");
      out.write("				User ID and Password</p>\n");
      out.write("			<form action=\"app/login\" id=\"login-form\" method=\"post\">\n");
      out.write("				<label for=\"userId\" style=\"margin-bottom: 10px;\">User ID</label> <input\n");
      out.write("					id=\"userId\" type=\"number\"\n");
      out.write("					name=\"");
      out.print(Parameters.USERID.parameterName());
      out.write("\" class=\"login-element\"\n");
      out.write("					required> <span class=\"error-text\" id=\"e-userId\"></span> <label\n");
      out.write("					for=\"password\" class=\"login-element\">Password</label> <input\n");
      out.write("					id=\"password\" type=\"password\"\n");
      out.write("					name=\"");
      out.print(Parameters.PASSWORD.parameterName());
      out.write("\"\n");
      out.write("					class=\"login-element\" required> <span class=\"error-text\"\n");
      out.write("					id=\"e-password\"></span>\n");
      out.write("				<h5>\n");
      out.write("					Forgot password, <a href=\"reset_password\"\n");
      out.write("						style=\"color: white; font-weight: bold;\">click here to reset</a>\n");
      out.write("				</h5>\n");
      out.write("				<div style=\"margin: 5px 0\"></div>\n");
      out.write("				<label>Human Verification</label>\n");
      out.write("				<div class=\"g-recaptcha\" data-theme=\"dark\" id=\"captcha\"\n");
      out.write("					style=\"margin: 10px 0px\"\n");
      out.write("					data-sitekey=\"6LeyIuYpAAAAABrOOV8oTgPY0BXUAwbq1FXoIPtf\"\n");
      out.write("					data-action=\"LOGIN\"></div>\n");
      out.write("				<span class=\"error-text\" id=\"e-captcha\"></span> <input\n");
      out.write("					class=\"login-element\" type=\"submit\" value=\"Login\"\n");
      out.write("					style=\"margin-top: 20px;\">\n");
      out.write("			</form>\n");
      out.write("			<br>\n");
      out.write("			<p>\n");
      out.write("				New User, <a href=\"signup\" style=\"color: white; font-weight: bold;\">Click\n");
      out.write("					here to Sign up</a>\n");
      out.write("			</p>\n");
      out.write("		</div>\n");
      out.write("	</div>\n");
      out.write("</body>\n");
      out.write("\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
