package com.cskbank.utility;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cskbank.exceptions.AppException;
import com.cskbank.filters.Parameters;
import com.cskbank.modules.UserRecord;
import com.cskbank.utility.ConstantsUtil.Gender;
import com.cskbank.utility.ConstantsUtil.Status;

public class ServletUtil {

	public ServletUtil() throws AppException {
	}

	public static HttpSession session(HttpServletRequest request) throws ServletException, IOException {
		return request.getSession(false);
	}

	public static UserRecord getUser(HttpServletRequest request) throws ServletException, IOException {
		return (UserRecord) ServletUtil.session(request).getAttribute("user");
	}

	public static UserRecord getUnverifiedUser(HttpServletRequest request) throws ServletException, IOException {
		return (UserRecord) ServletUtil.session(request).getAttribute("unverified_user");
	}

	public static String getRedirectContextURL(HttpServletRequest request, String redirect) {
		return request.getContextPath() + "/" + redirect;
	}

	public static String getRootRedirect(HttpServletRequest request) {
		return request.getContextPath() + "/";
	}

	public static String getLoginRedirect(HttpServletRequest request) {
		return getRedirectContextURL(request, "login");
	}

	public static void commonAuthorizationCheck(Map<String, String[]> parameters) throws AppException {
		checkRequiredParameters(parameters, List.of(Parameters.OPERATION));
		String operation = parameters.get(Parameters.OPERATION.parameterName())[0];
		if (operation.startsWith("process")) {
			checkRequiredParameters(parameters, List.of(Parameters.PIN));
		} else if (operation.equals("authorize_change_password")) {
			checkRequiredParameters(parameters, List.of(Parameters.OLDPASSWORD, Parameters.NEWPASSWORD));
		}
	}

	public static void checkRequiredParameters(Map<String, String[]> requestParameters,
			List<Parameters> requiredParameters) throws AppException {
		for (Parameters parameter : requiredParameters) {
			try {
				String parameterName = parameter.parameterName();
				if (requestParameters.containsKey(parameterName)) {
					validateParameters(parameter, requestParameters.get(parameterName)[0]);
				} else {
					throw new AppException("Input not obtained");
				}
			} catch (AppException e) {
				throw new AppException("Error at input : " + parameter + "<br>" + e.getMessage());
			}
		}
	}

	private static void validateParameters(Parameters parameter, String parameterValue) throws AppException {

		switch (parameter) {
		case USERID:
		case CURRENTPAGE:
			ValidatorUtil.validateId(ConvertorUtil.convertStringToInteger(parameterValue));
			break;

		case PASSWORD:
		case OLDPASSWORD:
		case NEWPASSWORD:
			ValidatorUtil.validatePassword(parameterValue);
			break;

		case FROMACCOUNT:
		case TOACCOUNT:
		case ACCOUNTNUMBER:
		case AKID:
			ValidatorUtil.validateId(ConvertorUtil.convertStringToLong(parameterValue));
			break;

		case IFSC:
		case TRANSACTIONLIMIT:
		case OPERATION:
		case SEARCHBY:
		case TYPE:
		case CUSTOMERTYPE:
		case ADDRESS:
		case ORGNAME:
		case REASON:
			ValidatorUtil.validateObject(parameterValue);
			break;

		case STATUS:
			ConvertorUtil.convertToEnum(Status.class, parameterValue);
			break;

		case GENDER:
			ConvertorUtil.convertToEnum(Gender.class, parameterValue);
			break;

		case PAGECOUNT:
			ConvertorUtil.convertStringToInteger(parameterValue);
			break;

		case AMOUNT:
			ConvertorUtil.convertStringToDouble(parameterValue);
			break;

		case FIRSTNAME:
			ValidatorUtil.validateFirstName(parameterValue);
			break;

		case LASTNAME:
			ValidatorUtil.validateLastName(parameterValue);
			break;

		case PHONE:
			ValidatorUtil.validateMobileNumber(ConvertorUtil.convertStringToLong(parameterValue));
			break;

		case EMAIL:
			ValidatorUtil.validateEmail(parameterValue);
			break;

		case AADHAAR:
			ValidatorUtil.validateAadhaarNumber(ConvertorUtil.convertStringToLong(parameterValue));
			break;

		case PAN:
			ValidatorUtil.validatePANNumber(parameterValue);
			break;

		case STARTDATE:
		case ENDDATE:
		case DATEOFBIRTH:
			ValidatorUtil.validateDateString(parameterValue);
			break;

		case TRANSFERWITHINBANK:
		default:
			break;
		}

	}
}
