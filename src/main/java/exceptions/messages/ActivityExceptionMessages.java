package exceptions.messages;

import utility.ConstantsUtil;

public enum ActivityExceptionMessages {

	CANNOT_LOAD_CONNECTOR("Persistance layer not found"),

	CANNOT_TRANSFER_TO_SAME_ACCOUNT("Amount cannot be transferred within the same account"),
	INVALID_EMPLOYEE_RECORD("The employee record obtained is not valid."),
	SERVER_CONNECTION_LOST("The connection to server is lost. Logging out."),
	USER_AUTHORIZATION_FAILED("User Authorization failed."),
	EMPLOYEE_UNAUTHORIZED("Operation Forbidden. Cannot be process by current user"),
	NO_CUSTOMER_RECORD_FOUND("The customer record for the following Customer ID was not found"),
	NO_EMPLOYEE_RECORD_FOUND("The employee record for the following ID was not found"),
	MODIFICATION_ACCESS_DENIED("You do not have permission to modify this data"),
	MINIMUM_DEPOSIT_REQUIRED(
			"The deposit amount must meet the minimum required amount. The minimum deposit amount is Rs. "
					+ ConstantsUtil.MINIMUM_DEPOSIT_AMOUNT),
	CLEAR_BALANCE_TO_CLOSE_ACCOUNT(
			"The balance in the account needs to be withdrawn or transferred to another account before it can be closed"),

	API_KEY_EXPIRED("The api key obtained has expired"),

	INVALID_START_DATE("Start Date of range cannot be greater than the end date"),
	EQUAL_START_END_DATE("Start Date and End Date cannot be the same"),
	INVALID_END_DATE("End date cannot be greater than the current date");

	private String message;

	private ActivityExceptionMessages(String message) {
		this.message = message;
	}

	public String toString() {
		return message;
	}

}
