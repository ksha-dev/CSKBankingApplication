<%@page import="utility.ConstantsUtil"%>
<%@page import="utility.ConvertorUtil"%>
<%@page import="modules.EmployeeRecord"%>
<%@page import="modules.Branch"%>
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
		style="display: flex; justify-content: space-between; align-items: center">
		<h3 class="content-title" style="padding-right: 10px">
			Employees in
			<%=branch.getAddress()%>
			Branch
		</h3>
		<a href="add_employee" style="color: white;"> <i
			class="material-icons">add_circle</i>
		</a>
		<div style="margin: auto"></div>
		<form action="employee_details" method="post">
			<input type="number" name="id" placeholder="Search Employee"
				style="margin-right: 50px" required="required">
		</form>
	</div>
	<%
	if (employees.isEmpty()) {
	%>
	<div class="container">No employees have been assign to this
		branch yet</div>
	<%
	} else {
	%>
	<div id="accountsTable" class="content-table">
		<table width="100%">
			<thead>
				<tr>
					<td>Employee ID</td>
					<td>Employee Name</td>
					<td>Date of Birth</td>
					<td>Phone</td>
					<td>Email</td>
					<td>Role</td>
					<td></td>
				</tr>
			</thead>
			<tbody>
				<%
				for (EmployeeRecord employee : employees.values()) {
				%>
				<tr>
					<td><%=employee.getUserId()%></td>
					<td><%=employee.getFirstName()%> <%=employee.getLastName()%></td>
					<td><%=ConvertorUtil.formatToDate(employee.getDateOfBirth())%></td>
					<td><%=employee.getPhone()%></td>
					<td><%=employee.getEmail()%></td>
					<td><%=employee.getType()%></td>
					<td>
						<form action="employee_details" method="post">
							<input type="hidden" name="id" value="<%=employee.getUserId()%>">
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