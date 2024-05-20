package com.cskbank.modules;

import com.cskbank.exceptions.AppException;
import com.cskbank.utility.ConstantsUtil;
import com.cskbank.utility.ConvertorUtil;
import com.cskbank.utility.ValidatorUtil;

public class OTP {
	private String otp;
	private String email;
	private int retryCount;
	private int regenerationCount;
	private long expiresAt;

	// setters

	public void setOTP(String otp) throws AppException {
		ValidatorUtil.validateOTP(otp);
		this.otp = otp;
	}

	public void setEmail(String email) throws AppException {
		ValidatorUtil.validateEmail(email);
		this.email = email;
	}

	public void setRetryCount(int retryCount) {
		this.retryCount = (retryCount > ConstantsUtil.MAX_RETRY_COUNT || retryCount < 0) ? ConstantsUtil.MAX_RETRY_COUNT
				: retryCount;
	}

	public void setRegenerationCount(int generatedCount) {
		this.regenerationCount = (generatedCount > ConstantsUtil.MAX_REGENERATION_COUNT || generatedCount < 0)
				? ConstantsUtil.MAX_REGENERATION_COUNT
				: generatedCount;
	}

	public void setExpiresAt(long expiresAt) {
		this.expiresAt = expiresAt;
	}

	// getters

	public String getOTP() {
		return otp;
	}

	public String getEmail() {
		return email;
	}

	public int getRetryCount() {
		return retryCount;
	}

	public int getRegenerationCount() {
		return regenerationCount;
	}

	public long getExpiresAt() {
		return expiresAt;
	}

	// helper method

	public boolean isOTPExpired() {
		return System.currentTimeMillis() > expiresAt;
	}

	public void reduceRetryCount() {
		retryCount = retryCount - 1;
	}
}
