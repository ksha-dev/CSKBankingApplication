/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.x-dev
 * Generated at: 2024-06-21 12:24:40 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.jsp.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import com.cskbank.utility.ConstantsUtil;
import com.cskbank.utility.ConvertorUtil;
import com.cskbank.modules.EmployeeRecord;
import com.cskbank.modules.Branch;
import java.util.Objects;
import com.cskbank.modules.UserRecord;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.Map;
import java.util.List;

public final class employees_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(3);
    _jspx_dependants.put("/WEB-INF/jsp/admin/../include/layout_header.jsp", Long.valueOf(1718972486674L));
    _jspx_dependants.put("/WEB-INF/jsp/admin/../include/head.jsp", Long.valueOf(1718972486674L));
    _jspx_dependants.put("/WEB-INF/jsp/admin/../include/layout_footer.jsp", Long.valueOf(1718972486674L));
  }

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.LinkedHashSet<>(3);
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.LinkedHashSet<>(10);
    _jspx_imports_classes.add("com.cskbank.utility.ConstantsUtil");
    _jspx_imports_classes.add("java.util.Objects");
    _jspx_imports_classes.add("java.util.List");
    _jspx_imports_classes.add("java.util.Map");
    _jspx_imports_classes.add("com.cskbank.utility.ConvertorUtil");
    _jspx_imports_classes.add("java.util.HashMap");
    _jspx_imports_classes.add("com.cskbank.modules.EmployeeRecord");
    _jspx_imports_classes.add("com.cskbank.modules.UserRecord");
    _jspx_imports_classes.add("com.cskbank.modules.Branch");
    _jspx_imports_classes.add("java.util.ArrayList");
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


Branch branch = (Branch) request.getAttribute("branch");
Map<Integer, EmployeeRecord> employees = (Map) request.getAttribute("employees");
int pageCount = (int) request.getAttribute("pageCount");
int currentPage = (int) request.getAttribute("currentPage");

      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("<title>Employees</title>\n");
      out.write("<meta charset=\"UTF-8\">\n");
      out.write("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("<link rel=\"stylesheet\" href=\"../../static/css/styles.css\">\n");
      out.write("<link rel=\"stylesheet\"\n");
      out.write("	href=\"https://fonts.googleapis.com/icon?family=Material+Icons\">\n");
      out.write("<script src=\"../../static/script/script.js\"></script>\n");
      out.write("\n");
String error = (String) request.getSession(false).getAttribute("error");
if (error != null) {
	request.getSession(false).removeAttribute("error");
	out.print("<script>errorMessage('" + error + "');</script>");
}
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("	");

UserRecord user = (UserRecord) session.getAttribute("user");

      out.write("<section id=\"menu\">\n");
      out.write("	<div class=\"logo\">\n");
      out.write("		<img src=\"../../static/images/logo.png\" alt=\"CSK Bank Logo\">\n");
      out.write("		<h2>CSK Bank</h2>\n");
      out.write("	</div>\n");
      out.write("\n");
      out.write("	<div class=\"items\">\n");
      out.write("		");

		switch (user.getType()) {
			case CUSTOMER : {
		
      out.write("<a id=\"a-account\" href=\"account\">\n");
      out.write("			<li id='li-account'><i class=\"material-icons\">account_balance</i>Account</li>\n");
      out.write("		</a> <a id=\"a-statement\" href=\"statement\">\n");
      out.write("			<li id=\"li-statement\"><i class=\"material-icons\">receipt_long</i>Statement</li>\n");
      out.write("		</a> <a id=\"a-transfer\" href=\"transfer\">\n");
      out.write("			<li id=\"li-transfer\"><i class=\"material-icons\">payments</i>Transfer</li>\n");
      out.write("		</a>\n");
      out.write("		");

		}
		break;
		case ADMIN : {
		
      out.write("<a id=\"a-employees\" href=\"employees\">\n");
      out.write("			<li id='li-employees'><i class=\"material-icons\">groups</i>Employees</li>\n");
      out.write("		</a> <a id=\"a-branches\" href=\"branches\">\n");
      out.write("			<li id='li-branches'><i class=\"material-icons\">location_city</i>Branches</li>\n");
      out.write("		</a> <a id=\"a-accounts\" href=\"accounts\">\n");
      out.write("			<li id='li-accounts'><i class=\"material-icons\">account_balance</i>Accounts</li>\n");
      out.write("		</a> <a id=\"a-api_service\" href=\"api_service\">\n");
      out.write("			<li id='li-api_service'><i class=\"material-icons\">api</i>API\n");
      out.write("				Service</li>\n");
      out.write("		</a>\n");
      out.write("		");

		}
		case EMPLOYEE : {
		if (user.getType() != UserRecord.Type.ADMIN) {
		
      out.write("<a id=\"a-branch_accounts\" href=\"branch_accounts\">\n");
      out.write("			<li id='li-branch_accounts'><i class=\"material-icons\">account_balance</i>Branch\n");
      out.write("				Accounts</li>\n");
      out.write("		</a> <a id=\"a-open_account\" href=\"open_account\">\n");
      out.write("			<li id=\"li-open_account\"><i class=\"material-icons\">library_add</i>Open\n");
      out.write("				Account</li>\n");
      out.write("		</a>\n");
      out.write("		");

		}
		
      out.write("<a id=\"a-search\" href=\"search\">\n");
      out.write("			<li id=\"li-search\"><i class=\"material-icons\">search</i>Search</li>\n");
      out.write("		</a><a id=\"a-statement\" href=\"statement\">\n");
      out.write("			<li id=\"li-statement\"><i class=\"material-icons\">receipt_long</i>Statement</li>\n");
      out.write("		</a> <a id=\"a-transaction\" href=\"transaction\">\n");
      out.write("			<li id=\"li-transaction\"><i class=\"material-icons\">payments</i>Transaction</li>\n");
      out.write("		</a>\n");
      out.write("		");

		}
		break;
		}
		
      out.write("<a id=\"a-change_password\" href=\"change_password\">\n");
      out.write("			<li id=\"li-change_password\"><i class=\"material-icons\">lock_reset</i>Change\n");
      out.write("				Password</li>\n");
      out.write("		</a> <a href=\"#\" onclick=\"logout()\">\n");
      out.write("			<li><i class=\"material-icons\">logout</i>Logout</li>\n");
      out.write("		</a>\n");
      out.write("	</div>\n");
      out.write("</section>\n");
      out.write("\n");
      out.write("<script>\n");
      out.write("	const url = window.location.pathname;\n");
      out.write("	const fileName = url.substring(url.lastIndexOf('/') + 1);\n");
      out.write("	document.getElementById('li-' + fileName).style = \"border-left: 5px solid #fff; background: #0d1117; color: white;\";\n");
      out.write("	document.getElementById('a-' + fileName).href = '#';\n");
      out.write("</script>\n");
      out.write("\n");
      out.write("<section id=\"content-area\">\n");
      out.write("	<div class=\"nav-bar\">\n");
      out.write("		<div></div>\n");
      out.write("		<div class=\"profile\">\n");
      out.write("			<div\n");
      out.write("				style=\"align-items: end; display: flex; flex-direction: column; padding-right: 15px;\">\n");
      out.write("				<h3>");
      out.print(user.getFirstName());
      out.write("</h3>\n");
      out.write("				<p style=\"font-size: 14px;\">\n");
      out.write("					User ID :\n");
      out.write("					");
      out.print(user.getUserId());
      out.write("</p>\n");
      out.write("			</div>\n");
      out.write("			<a id='profile' href=\"profile\"> <img\n");
      out.write("				src=\"../../static/images/profile.jpg\" alt=\"Profile\">\n");
      out.write("			</a>\n");
      out.write("		</div>\n");
      out.write("	</div>\n");
      out.write("\n");
      out.write("\n");
      out.write("	<div class=\"content-board\">");
      out.write("<div\n");
      out.write("		style=\"display: flex; justify-content: space-between; align-items: center; margin-right: 50px;\">\n");
      out.write("		<h3 class=\"content-title\">Employees Data</h3>\n");
      out.write("		<button onclick=\"location.href='add_employee'\" type=\"submit\">Add\n");
      out.write("			Employee</button>\n");
      out.write("	</div>\n");
      out.write("	");

	if (employees.isEmpty()) {
	
      out.write("<div class=\"container\">No data to display/</div>\n");
      out.write("	");

	} else {
	
      out.write("<div id=\"accountsTable\" class=\"content-table\">\n");
      out.write("		<table width=\"100%\">\n");
      out.write("			<thead>\n");
      out.write("				<tr>\n");
      out.write("					<td>Employee ID</td>\n");
      out.write("					<td>First Name</td>\n");
      out.write("					<td>Last</td>\n");
      out.write("					<td>Role</td>\n");
      out.write("					<td>Branch ID</td>\n");
      out.write("					<td></td>\n");
      out.write("				</tr>\n");
      out.write("			</thead>\n");
      out.write("			<tbody>\n");
      out.write("				");

				for (EmployeeRecord employee : employees.values()) {
				
      out.write("<tr>\n");
      out.write("					<td>");
      out.print(employee.getUserId());
      out.write("</td>\n");
      out.write("					<td>");
      out.print(employee.getFirstName());
      out.write("</td>\n");
      out.write("					<td>");
      out.print(employee.getLastName());
      out.write("</td>\n");
      out.write("					<td>");
      out.print(employee.getType());
      out.write("</td>\n");
      out.write("					<td>");
      out.print(employee.getBranchId());
      out.write("</td>\n");
      out.write("					<td>\n");
      out.write("						<form action=\"employee_details\" method=\"post\">\n");
      out.write("							<input type=\"hidden\" name=\"userId\"\n");
      out.write("								value=\"");
      out.print(employee.getUserId());
      out.write("\">\n");
      out.write("							<button type=\"submit\"\n");
      out.write("								style=\"background: none; border: none; padding: 0;\">\n");
      out.write("								<i class=\"material-icons\">keyboard_arrow_right</i>\n");
      out.write("							</button>\n");
      out.write("						</form>\n");
      out.write("					</td>\n");
      out.write("\n");
      out.write("				</tr>\n");
      out.write("				");

				}

				if (currentPage == pageCount) {
				int remainingCount = ConstantsUtil.LIST_LIMIT - employees.size();
				for (int t = 0; t < remainingCount; t++) {
					//out.println(
					//"<tr><td>-</td><td>-</td><td>-</td><td class=\"pr\">-</td><td class=\"pr\">-</td><td>-</td><td>-</td></tr>");
					out.println("<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>");
				}
				}
				
      out.write("</tbody>\n");
      out.write("		</table>\n");
      out.write("	</div>\n");
      out.write("\n");
      out.write("	<form action=\"");
      out.print(pageCount == 1 ? "#" : "employees");
      out.write("\"\n");
      out.write("		class=\"pagination\" method=\"post\">\n");
      out.write("		<button type=\"");
      out.print(currentPage == 1 ? "reset" : "submit");
      out.write("\"\n");
      out.write("			name=\"currentPage\" value=\"");
      out.print(currentPage - 1);
      out.write("\"\n");
      out.write("			style=\"margin-right: 20px;\">&laquo;</button>\n");
      out.write("		");

		for (int i = 1; i <= pageCount; i++) {
		
      out.write("<button type=\"");
      out.print(currentPage == i ? "reset" : "submit");
      out.write("\"\n");
      out.write("			name=\"currentPage\" value=\"");
      out.print(i);
      out.write("\"\n");
      out.write("			");
if (currentPage == i)
	out.println("class=\"active\"");
      out.write('>');
      out.print(i);
      out.write("</button>\n");
      out.write("		");

		}
		
      out.write("<br>\n");
      out.write("		<button type=\"");
      out.print(currentPage == pageCount ? "reset" : "submit");
      out.write("\"\n");
      out.write("			name=\"currentPage\" value=\"");
      out.print(currentPage + 1);
      out.write("\"\n");
      out.write("			style=\"margin-left: 20px;\">&raquo;</button>\n");
      out.write("		<input type=\"hidden\" name=\"pageCount\" value=\"");
      out.print(pageCount);
      out.write("\">\n");
      out.write("		");

		}
		
      out.write("</form>\n");
      out.write("	");
      out.write("</div>\n");
      out.write("</section>");
      out.write("</body>\n");
      out.write("</body>\n");
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
