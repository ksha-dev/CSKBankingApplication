package modules;

import exceptions.AppException;
import utility.ValidatorUtil;

public class APIKey {
	private long akId;
	private String orgName;
	private String apiKey;
	private long createdAt;
	private long validUntil;
	private long modifiedAt;
	private boolean isActive;

	public APIKey() {
	}

	// Setters

	public void setAkId(long akId) throws AppException {
		ValidatorUtil.validateId(akId);
		this.akId = akId;
	}

	public void setOrgName(String orgName) throws AppException {
		ValidatorUtil.validateObject(orgName);
		this.orgName = orgName;
	}

	public void setAPIKey(String apiKey) throws AppException {
		ValidatorUtil.validateAPIKey(apiKey);
		this.apiKey = apiKey;
	}

	public void setCreatedAt(long createdAt) {
		this.createdAt = createdAt;
	}

	public void setValidUntil(long validUntil) {
		this.validUntil = validUntil;
	}

	public void setModifiedAt(long modifiedAt) {
		this.modifiedAt = modifiedAt;
	}

	public void setIsActive(boolean isActive) {
		this.isActive = isActive;
	}

	// Getters

	public long getAkId() {
		return this.akId;
	}

	public String getOrgName() {
		return this.orgName;
	}

	public String getAPIKey() {
		return this.apiKey;
	}

	public long getCreatedAt() {
		return this.createdAt;
	}

	public long getValidUntil() {
		return this.validUntil;
	}

	public long getModifiedAt() {
		return this.modifiedAt;
	}

	public boolean getIsActive() {
		return this.isActive;
	}

}