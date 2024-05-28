<%@page import="com.cskbank.utility.ConstantsUtil"%>
<%@page import="com.cskbank.utility.ConvertorUtil"%>
<%@page import="com.cskbank.modules.EmployeeRecord"%>
<%@page import="com.cskbank.modules.Branch"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
Branch branch = (Branch) request.getAttribute("branch");
Map<Integer, EmployeeRecord> employees = (Map) request.getAttribute("employees");
int pageCount = (int) request.getAttribute("pageCount");
int currentPage = (int) request.getAttribute("currentPage");
%>

<!DOCTYPE html>
<html>
<head>
<title>Employees</title>
<%@include file="../include/head.jsp"%>
</head>
<body>
	<%@include file="../include/layout_header.jsp"%>
	<div
		style="display: flex; justify-content: space-between; align-items: center; margin-right: 50px;">
		<h3 class="content-title">Employees Data</h3>
		<button onclick="location.href='add_employee'" type="submit">Add
			Employee</button>
	</div>
	<%
	if (employees.isEmpty()) {
	%>
	<div class="container">No data to display/</div>
	<%
	} else {
	%>
	<div id="accountsTable" class="content-table">
		<table width="100%">
			<thead>
				<tr>
					<td>Employee ID</td>
					<td>Branch ID</td>
					<td>Employee Name</td>
					<td>Phone</td>
					<td>Email</td>
					<td></td>
				</tr>
			</thead>
			<tbody>
				<%
				for (EmployeeRecord employee : employees.values()) {
				%>
				<tr>
					<td><%=employee.getUserId()%></td>
					<td><%=employee.getBranchId()%></td>
					<td><%=employee.getFirstName()%> <%=employee.getLastName()%></td>
					<td><%=employee.getPhone()%></td>
					<td><%=employee.getEmail()%></td>
					<td>
						<form action="employee_details" method="post">
							<input type="hidden" name="userId"
								value="<%=employee.getUserId()%>">
							<button type="submit"
								style="background: none; border: none; padding: 0;">
								<i class="material-icons">keyboard_arrow_right</i>
							</button>
						</form>
					</td>

				</tr>
				<%
				}

				if (currentPage == pageCount) {
				int remainingCount = ConstantsUtil.LIST_LIMIT - employees.size();
				for (int t = 0; t < remainingCount; t++) {
					//out.println(
					//"<tr><td>-</td><td>-</td><td>-</td><td class=\"pr\">-</td><td class=\"pr\">-</td><td>-</td><td>-</td></tr>");
					out.println("<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>");
				}
				}
				%>
			</tbody>
		</table>
	</div>

	<form action="<%=pageCount == 1 ? "#" : "employees"%>"
		class="pagination" method="post">
		<button type="<%=currentPage == 1 ? "reset" : "submit"%>"
			name="currentPage" value="<%=currentPage - 1%>"
			style="margin-right: 20px;">&laquo;</button>
		<%
		for (int i = 1; i <= pageCount; i++) {
		%>
		<button type="<%=currentPage == i ? "reset" : "submit"%>"
			name="currentPage" value="<%=i%>"
			<%if (currentPage == i)
	out.println("class=\"active\"");%>><%=i%></button>
		<%
		}
		%>
		<br>
		<button type="<%=currentPage == pageCount ? "reset" : "submit"%>"
			name="currentPage" value="<%=currentPage + 1%>"
			style="margin-left: 20px;">&raquo;</button>
		<input type="hidden" name="pageCount" value="<%=pageCount%>">
		<%
		}
		%>
	</form>
	<%@include file="../include/layout_footer.jsp"%>
</body>
</body>
</html>