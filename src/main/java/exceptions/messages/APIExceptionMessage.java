package exceptions.messages;

public enum APIExceptionMessage {
	USER_NOT_FOUND("The user record for the given information does not exist."),
	CUSTOMER_RECORD_NOT_FOUND("The valid customer details for the user does not exist."),
	EMPLOYEE_RECORD_NOT_FOUND("The valid employee details for the user does not exist."),
	ACCOUNT_RECORD_NOT_FOUND("No account exists with the given account number."),
	USER_AUNTHENTICATION_FAILED("The credentials entered for the acount is incorrect. Please try again"),
	NO_SERVER_CONNECTION("Unable to connect to server. Please try again after sometime. Sorry for the inconvenience"),
	LOGGING_FAILED("An internal error occured during log operation"),

	NO_RECORDS_FOUND("No matching records were found."), CANNOT_FETCH_DETAILS("Unable to fetch details at the moment"),
	UNKNOWN_USER_OR_BRANCH("There might be no records with the given User ID or Branch ID."),
	CANNOT_GET_API_KEY("Failed to obtained the API Key"),

	USER_CREATION_FAILED("Unable to create user record at the moment"),
	EMPLOYEE_CREATION_FAILED("Unable to create employee record at the moment"),
	ACCOUNT_CREATION_FAILED("Failed to create a new Account."), API_GENERATION_FAILED("Failed to generate API Key"),
	CUSTOMER_CREATION_FAILED("Unable to create customer record at the moment"),
	BRANCH_CREATION_FAILED("Failed to create Branch Record"),

	API_KEY_NOT_FOUND("The API Key obtained is not valid or does not exist"),
	UNKNOWN_ERROR("An unexpected error occured. Please try again after sometime"),
	CANNOT_MODIFY_STATUS("The status of a closed account cannot be changed"),
	STATUS_ALREADY_SET("The account is already in the required state"),
	ACCOUNT_RESTRICTED("This account has been restricted for transactions."),
	ACCOUNT_FROZEN(
			"This account has been frozen due to prolonged inactivity. Please deposit an amount at the nearest bank to reactive it."),
	ACCOUNT_CLOSED("The account has been closed."),

	DB_COMMUNICATION_FAILED("The data could not be fetched from the server"),

	UPDATE_FAILED("Cannot update the details. Please try again"),
	IFSC_CODE_UPDATE_FAILED("The IFSC Code of the bank could not be set. Record will not be created"),
	STATUS_UPDATE_FAILED("Cannot change the account status."),
	BALANCE_ACQUISITION_FAILED("The balance amount for the given account could not be obtained."),
	INSUFFICIENT_BALANCE("The account selected does not contain sufficient balance for the transaction"),
	TRANSACTION_FAILED("The transaction has failed. Any changes done will be reverted in few minutes."),
	USER_CONFIRMATION_FAILED("Confirmation Failed. Cannot process the request"),
	SAME_PASSWORD("New password cannot be the same as old password."),
	BRANCH_DETAILS_NOT_FOUND("Cannot find a linked branch details");

	private String message;

	private APIExceptionMessage(String message) {
		this.message = message;
	}

	public String toString() {
		return this.message;
	}
}
