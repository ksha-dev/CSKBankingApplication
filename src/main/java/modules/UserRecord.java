package modules;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.ZonedDateTime;

import exceptions.AppException;
import utility.ValidatorUtil;
import utility.ConstantsUtil.Gender;
import utility.ConstantsUtil.UserType;
import utility.ConvertorUtil;

public abstract class UserRecord implements Serializable {

	private int userId;
	private String firstName;
	private String lastName;
	private long dateOfBirth;
	private Gender gender;
	private String address;
	private long mobileNumber;
	private String email;
	private UserType type;
	private int modifiedBy;
	private long createdAt;
	private long modifiedAt;

	public void setUserId(int userId) {
		this.userId = userId;
	}

	// Setters

	public void setFirstName(String firstName) throws AppException {
		ValidatorUtil.validateFirstName(firstName);
		this.firstName = firstName;
	}

	public void setLastName(String lastName) throws AppException {
		ValidatorUtil.validateLastName(lastName);
		this.lastName = lastName;
	}

	public void setDateOfBirth(long dateOfBirth) throws AppException {
		ValidatorUtil.validateDateOfBirth(dateOfBirth);
		this.dateOfBirth = dateOfBirth;
	}

	public void setDateOfBirth(ZonedDateTime dateOfBirth) throws AppException {
		long temp = ConvertorUtil.convertToMilliSeconds(dateOfBirth);
		ValidatorUtil.validateDateOfBirth(temp);
		this.dateOfBirth = temp;
	}

	public void setGender(int genderId) throws AppException {
		this.gender = Gender.getGender(genderId);
	}

	public void setAddress(String address) throws AppException {
		ValidatorUtil.validateObject(address);
		this.address = address;
	}

	public void setPhone(long mobileNumber) throws AppException {
		ValidatorUtil.validateMobileNumber(mobileNumber);
		this.mobileNumber = mobileNumber;
	}

	public void setEmail(String email) throws AppException {
		ValidatorUtil.validateEmail(email);
		this.email = email;
	}

	public void setType(int userTypeId) throws AppException {
		this.type = UserType.getUserType(userTypeId);
	}

	public void setCreatedAt(long dateTime) {
		this.createdAt = dateTime;
	}

	public void setModifiedBy(int userId) throws AppException {
		ValidatorUtil.validateId(userId);
		this.modifiedBy = userId;
	}

	public void setModifiedAt(long dateTime) {
		this.modifiedAt = dateTime;
	}

	// Getters

	public int getUserId() {
		return userId;
	}

	public String getFirstName() throws AppException {
		ValidatorUtil.validateFirstName(firstName);
		return firstName;
	}

	public String getLastName() throws AppException {
		ValidatorUtil.validateLastName(lastName);
		return lastName;
	}

	public LocalDate getDateOfBirthInLocalDate() {
		return ConvertorUtil.convertLongToLocalDate(dateOfBirth);
	}

	public long getDateOfBirth() {
		return dateOfBirth;
	}

	public Gender getGender() {
		return gender;
	}

	public String getAddress() {
		return ValidatorUtil.isObjectNull(address) ? "-" : address;
	}

	public long getPhone() {
		return mobileNumber;
	}

	public String getEmail() throws AppException {
		ValidatorUtil.validateEmail(email);
		return email;
	}

	public UserType getType() {
		return type;
	}

	public int getModifiedBy() {
		return this.modifiedBy;
	}

	public long getCreatedAt() {
		return this.createdAt;
	}

	public long getModifiedAt() {
		return this.modifiedAt;
	}
}