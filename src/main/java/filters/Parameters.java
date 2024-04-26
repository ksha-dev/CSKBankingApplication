package filters;

public enum Parameters {
	USERID("userId", "User ID"), PASSWORD("password", "Password"), ACCOUNTNUMBER("accountNumber", "Account Number"),
	TRANSACTIONLIMIT("transactionLimit", "Statement Duration"), PAGECOUNT("pageCount", "Number of pages"),
	CURRENTPAGE("currentPage", "Current Page"), OPERATION("operation", "Operation"),
	FROMACCOUNT("fromAccount", "Sender Account Number"), TOACCOUNT("toAccount", "Receiver Account Number"),
	TRANSFERWITHINBANK("transferWithinBank", "Transfer Within Bank"), IFSC("ifsc", "IFSC Code"),
	AMOUNT("amount", "Amount"), REMARKS("remarks", "Remarks"), OLDPASSWORD("oldPassword", "Old Password"),
	NEWPASSWORD("newPassword", "New Password"), SEARCHBY("searchBy", "Search By"),
	SEARCHVALUE("searchValue", "Search Value"), PIN("pin", "PIN"), TYPE("type", "Type"),
	CUSTOMERTYPE("customerType", "Customer Type"), FIRSTNAME("firstName", "First Name"),
	LASTNAME("secondName", "Second Name"), DATEOFBIRTH("dateOfBirth", "Date of Birth"), ADDRESS("address", "Address"),
	PHONE("phone", "Phone Number"), EMAIL("email", "Email ID"), AADHAAR("aadhaar", "Aadhaar Number"),
	GENDER("gender", "Gender"), PAN("pan", "PAN Number"), STARTDATE("startDate", "Start Date"),
	ENDDATE("endDate", "End Date"), ROLE("role", "Role"), BRANCHID("branchId", "Branch ID"),
	AKID("ak_id", "API Key ID"), ORGNAME("orgName", "Organisation Name");

	private String parameterName;
	private String parameterDisplayName;

	private Parameters(String name, String displayName) {
		this.parameterName = name;
		this.parameterDisplayName = displayName;
	}

	public String toString() {
		return this.parameterDisplayName;
	}

	public String parameterName() {
		return this.parameterName;
	}
}