package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import exceptions.AppException;
import filters.Parameters;
import modules.Branch;
import modules.EmployeeRecord;
import operations.AdminOperations;
import operations.AppOperations;
import utility.ConstantsUtil.LogOperation;
import utility.ConstantsUtil.OperationStatus;
import utility.ConvertorUtil;
import utility.ServletUtil;

public class AdminControllerMethods {

	public AdminControllerMethods() throws AppException {
	};

	private AdminOperations operations = new AdminOperations();
	private AppOperations appOperations = new AppOperations();

	public void accountsRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, AppException {
		int pageCount = operations.getPageCountOfAccountsInBank();
		int currentPage = 1;
		if (request.getMethod().equals("POST")) {
			currentPage = ConvertorUtil
					.convertStringToInteger(request.getParameter(Parameters.CURRENTPAGE.parameterName()));
		}
		request.setAttribute("accounts", operations.viewAccountsInBank(currentPage));
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("pageCount", pageCount);
		request.getRequestDispatcher("/WEB-INF/jsp/admin/accounts.jsp").forward(request, response);
	}

	public void branchesRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, AppException {
		int pageCount = operations.getPageCountOfBranches();
		int currentPage = 1;
		if (request.getMethod().equals("POST")) {
			currentPage = ConvertorUtil
					.convertStringToInteger(request.getParameter(Parameters.CURRENTPAGE.parameterName()));
		}
		request.setAttribute("branches", operations.viewBrachesInBank(currentPage));
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("pageCount", pageCount);
		request.getRequestDispatcher("/WEB-INF/jsp/admin/branches.jsp").forward(request, response);
	}

	public void employeesRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, AppException {
		EmployeeRecord admin = (EmployeeRecord) ServletUtil.getUser(request);
		int pageCount = operations.getPageCountOfEmployees();
		int currentPage = 1;
		if (request.getMethod().equals("POST")) {
			currentPage = ConvertorUtil
					.convertStringToInteger(request.getParameter(Parameters.CURRENTPAGE.parameterName()));
		}
		request.setAttribute("employees", operations.getEmployees(currentPage));
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("branch", operations.getBranch(admin.getBranchId()));
		request.getRequestDispatcher("/WEB-INF/jsp/admin/employees.jsp").forward(request, response);
	}

	public void employeeDetailsPostMethod(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, AppException {
		EmployeeRecord admin = (EmployeeRecord) ServletUtil.getUser(request);
		int employeeId = ConvertorUtil.convertStringToInteger(request.getParameter(Parameters.USERID.parameterName()));
		try {
			request.setAttribute("employee", operations.getEmployeeDetails(employeeId));
			request.getRequestDispatcher("/WEB-INF/jsp/admin/employee_details.jsp").forward(request, response);

			// Log
			appOperations.logOperationByUser(admin.getUserId(), employeeId, LogOperation.VIEW_EMPLOYEE,
					OperationStatus.SUCCESS,
					"Employee details (ID : " + employeeId + ") was viewed by Admin (ID :  " + admin.getUserId() + ")",
					System.currentTimeMillis());

		} catch (AppException e) {
			ServletUtil.session(request).setAttribute("error", e.getMessage());
			response.sendRedirect("employees");
		}
	}

	public boolean searchPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, AppException {
		String searchBy = request.getParameter(Parameters.SEARCHBY.parameterName());
		String searchValue = request.getParameter(Parameters.SEARCHVALUE.parameterName());
		EmployeeRecord admin = (EmployeeRecord) ServletUtil.getUser(request);

		try {
			if (searchBy.equals("employeeId")) {
				int userId = ConvertorUtil.convertStringToInteger(searchValue);
				request.setAttribute("employee", (EmployeeRecord) operations.getEmployeeDetails(userId));
				request.getRequestDispatcher("/WEB-INF/jsp/admin/employee_details.jsp").forward(request, response);

				// Log
				appOperations.logOperationByUser(admin.getUserId(), userId, LogOperation.VIEW_EMPLOYEE,
						OperationStatus.SUCCESS, "Employee details (ID : " + userId
								+ ") was searched and viewed by Admin (ID :  " + admin.getUserId() + ")",
						System.currentTimeMillis());
			} else if (searchBy.equals("branchId")) {
				int branchId = ConvertorUtil.convertStringToInteger(searchValue);
				request.setAttribute("branch", operations.getBranch(branchId));
				request.getRequestDispatcher("/WEB-INF/jsp/admin/branch_details.jsp").forward(request, response);

				// Log
				appOperations.logOperationByAndForUser(admin.getUserId(), LogOperation.VIEW_BRANCH,
						OperationStatus.SUCCESS, "Branch details (ID : " + branchId
								+ ") was searched and viewed by Admin (ID :  " + admin.getUserId() + ")",
						System.currentTimeMillis());
			} else {
				return false;
			}
		} catch (AppException e) {
			ServletUtil.session(request).setAttribute("error", e.getMessage());
			response.sendRedirect("search");
		}
		return true;
	}

	public void authorizeAddEmployee(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, AppException {
		try {
			EmployeeRecord employee = new EmployeeRecord();
			employee.setFirstName(request.getParameter(Parameters.FIRSTNAME.parameterName()));
			employee.setLastName(request.getParameter(Parameters.LASTNAME.parameterName()));
			employee.setDateOfBirth(
					ConvertorUtil.dateStringToMillis(request.getParameter(Parameters.DATEOFBIRTH.parameterName())));
			employee.setGender(
					ConvertorUtil.convertStringToInteger(request.getParameter(Parameters.GENDER.parameterName())));
			employee.setAddress(request.getParameter(Parameters.ADDRESS.parameterName()));
			employee.setPhone(
					ConvertorUtil.convertStringToLong(request.getParameter(Parameters.PHONE.parameterName())));
			employee.setEmail(request.getParameter(Parameters.EMAIL.parameterName()));
			employee.setType(
					ConvertorUtil.convertStringToInteger(request.getParameter(Parameters.ROLE.parameterName())));
			employee.setBranchId(
					ConvertorUtil.convertStringToInteger(request.getParameter(Parameters.BRANCHID.parameterName())));
			ServletUtil.session(request).setAttribute("employee", employee);
			request.getRequestDispatcher("/WEB-INF/jsp/common/authorization.jsp?redirect=process_add_employee")
					.forward(request, response);
		} catch (AppException e) {
			ServletUtil.session(request).setAttribute("error", e.getMessage());
			response.sendRedirect("employees");
		}
	}

	public void processAddEmployeePostRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, AppException {
		EmployeeRecord admin = (EmployeeRecord) ServletUtil.getUser(request);
		String pin = request.getParameter(Parameters.PIN.parameterName());
		try {
			EmployeeRecord employee = (EmployeeRecord) ServletUtil.session(request).getAttribute("employee");

			// Log
			appOperations
					.logOperationByUser(admin.getUserId(), employee.getUserId(), LogOperation.CREATE_EMPLOYEE,
							OperationStatus.SUCCESS, "Employee (ID : " + employee.getUserId()
									+ ") was created by Admin (ID : " + admin.getUserId() + ")",
							employee.getCreatedAt());

			ServletUtil.session(request).removeAttribute("employee");
			operations.createEmployee(employee, admin.getUserId(), pin);
			request.setAttribute("message", "New employee has been created<br>Employee ID : " + employee.getUserId());
			request.setAttribute("status", true);
		} catch (AppException e) {
			request.setAttribute("status", false);
			request.setAttribute("message", e.getMessage());
			appOperations.logOperationByAndForUser(admin.getUserId(), LogOperation.CREATE_EMPLOYEE,
					OperationStatus.FAILURE,
					"Employee creation failed [Admin ID : " + admin.getUserId() + "] - " + e.getMessage(),
					System.currentTimeMillis());
		}
		request.setAttribute("redirect", "employees");
		request.setAttribute("operation", "add_employee");
		request.getRequestDispatcher("/WEB-INF/jsp/common/transaction_status.jsp").forward(request, response);
	}

	public void authorizeAddBranch(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, AppException {
		try {
			Branch branch = new Branch();
			branch.setAddress(request.getParameter(Parameters.ADDRESS.parameterName()));
			branch.setPhone(ConvertorUtil.convertStringToLong(request.getParameter(Parameters.PHONE.parameterName())));
			String emailPrefix = request.getParameter(Parameters.EMAIL.parameterName());
			if (emailPrefix.contains("@")) {
				emailPrefix.replaceAll("@.+$", "");
			}
			branch.setEmail(emailPrefix + "@cskbank.in");

			ServletUtil.session(request).setAttribute("branch", branch);
			request.getRequestDispatcher("/WEB-INF/jsp/common/authorization.jsp?redirect=process_add_branch")
					.forward(request, response);
		} catch (AppException e) {
			ServletUtil.session(request).setAttribute("error", e.getMessage());
			response.sendRedirect("branches");
		}
	}

	public void processAddBranchPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, AppException {
		String pin = request.getParameter(Parameters.PIN.parameterName());
		EmployeeRecord admin = (EmployeeRecord) ServletUtil.getUser(request);

		try {
			Branch branch = (Branch) ServletUtil.session(request).getAttribute("branch");
			ServletUtil.session(request).removeAttribute("branch");
			branch = operations.createBranch(branch, admin.getUserId(), pin);

			request.setAttribute("message",
					"New Branch Record has been created<br>Branch ID : " + branch.getBranchId());
			request.setAttribute("status", true);

			// Log
			appOperations.logOperationByAndForUser(
					admin.getUserId(), LogOperation.CREATE_BRANCH, OperationStatus.SUCCESS, "New Branch (ID : "
							+ branch.getBranchId() + ") was created by Admin (ID : " + admin.getUserId() + ")",
					branch.getCreatedAt());

		} catch (AppException e) {
			e.printStackTrace();
			request.setAttribute("status", false);
			request.setAttribute("message", e.getMessage());
			appOperations.logOperationByAndForUser(admin.getUserId(), LogOperation.CREATE_BRANCH,
					OperationStatus.FAILURE,
					"Branch creation failed [Admin ID : " + admin.getUserId() + "] - " + e.getMessage(),
					System.currentTimeMillis());
		}
		request.setAttribute("redirect", "branches");
		request.setAttribute("operation", "add_branch");
		request.getRequestDispatcher("/WEB-INF/jsp/common/transaction_status.jsp").forward(request, response);
	}
}
