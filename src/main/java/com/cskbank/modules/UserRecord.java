package com.cskbank.modules;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.ZonedDateTime;

import com.cskbank.exceptions.AppException;
import com.cskbank.exceptions.messages.InvalidInputMessage;
import com.cskbank.utility.ConstantsUtil.Gender;
import com.cskbank.utility.ConstantsUtil.Status;
import com.cskbank.utility.ConvertorUtil;
import com.cskbank.utility.ValidatorUtil;

public abstract class UserRecord implements Serializable {

	public static enum Type {
		CUSTOMER(3), EMPLOYEE(2), ADMIN(1);

		private int typeID;

		private Type(int typeID) {
			this.typeID = typeID;
		}

		public int getTypeID() {
			return this.typeID;
		}

		public static Type getType(int typeID) throws AppException {
			for (Type type : Type.values()) {
				if (type.typeID == typeID) {
					return type;
				}
			}
			throw new AppException(InvalidInputMessage.INVALID_IDENTIFIER);
		}

	}

	private int userId;
	private String firstName;
	private String lastName;
	private long dateOfBirth;
	private Gender gender;
	private String address;
	private long mobileNumber;
	private String email;
	private UserRecord.Type type;
	private Status status;
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

	public void setGender(String gender) throws AppException {
		this.gender = ConvertorUtil.convertToEnum(Gender.class, gender);
	}

	public void setGender(Gender gender) throws AppException {
		ValidatorUtil.validateObject(gender);
		this.gender = gender;
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

	public void setType(String userType) throws AppException {
		this.type = ConvertorUtil.convertToEnum(UserRecord.Type.class, userType);
	}

	public void setType(UserRecord.Type userType) throws AppException {
		ValidatorUtil.validateObject(userType);
		this.type = userType;
	}

	public void setStatus(Status status) throws AppException {
		ValidatorUtil.validateObject(status);
		this.status = status;
	}

	public void setStatus(String status) throws AppException {
		this.status = ConvertorUtil.convertToEnum(Status.class, status);
	}

	public void setCreatedAt(long dateTime) {
		this.createdAt = dateTime;
	}

	public void setModifiedBy(int userId) throws AppException {
		ValidatorUtil.validateId(userId);
		this.modifiedBy = userId;
	}

	public void setModifiedAt(Long dateTime) {
		this.modifiedAt = dateTime == null ? 0 : dateTime;
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

	public UserRecord.Type getType() {
		return type;
	}

	public Status getStatus() {
		return this.status;
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