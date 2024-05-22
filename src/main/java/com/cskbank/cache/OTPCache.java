package com.cskbank.cache;

import com.cskbank.exceptions.AppException;
import com.cskbank.modules.OTP;
import com.cskbank.utility.ConvertorUtil;
import com.cskbank.utility.ValidatorUtil;

import redis.clients.jedis.Jedis;

public class OTPCache {
	private static final String HOST_NAME = "localhost";
	private static final int PORT = 6379;
	private Jedis jedis;

	private static final String OTP_FIELD = "OTP";
	private static final String RETRY_COUNT_FIELD = "RETRY_COUNT";
	private static final String GENERATED_COUNT_FIELD = "GENERATED_COUNT";
	private static final String EXPIRATION_FIELD = "EXPIRES_IN";

	private static String otpKey(String email) {
		return OTP_FIELD + "-" + email;
	}

	public OTPCache() {
		jedis = new Jedis(HOST_NAME, PORT);
	}

	public synchronized boolean isValidOTPPresent(String email) throws AppException {
		ValidatorUtil.validateEmail(email);
		String otpkey = otpKey(email);
		if (jedis.exists(otpkey)) {
			long expiresAt = ConvertorUtil.convertStringToLong(jedis.hget(otpkey, EXPIRATION_FIELD));
			if (System.currentTimeMillis() > expiresAt) {
				removeOTP(email);
				return false;
			} else {
				return true;
			}
		}
		return false;
	}

	public synchronized void setOTP(OTP otp) throws AppException {
		ValidatorUtil.validateObject(otp);
		String otpKey = otpKey(otp.getEmail());
		System.out.println(otpKey);

		jedis.hset(otpKey, GENERATED_COUNT_FIELD, otp.getRegenerationCount() + "");
		jedis.hset(otpKey, RETRY_COUNT_FIELD, otp.getRetryCount() + "");
		jedis.hset(otpKey, OTP_FIELD, otp.getOTP());
		jedis.hset(otpKey, EXPIRATION_FIELD, otp.getExpiresAt() + "");
	}

	public synchronized OTP getOTP(String email) throws AppException {
		ValidatorUtil.validateEmail(email);
		String otpKey = otpKey(email);
		System.out.println(otpKey);

		if (jedis.exists(otpKey)) {
			OTP otp = new OTP();
			otp.setEmail(email);
			otp.setOTP(jedis.hget(otpKey, OTP_FIELD));
			otp.setRegenerationCount(ConvertorUtil.convertStringToInteger(jedis.hget(otpKey, GENERATED_COUNT_FIELD)));
			otp.setRetryCount(ConvertorUtil.convertStringToInteger(jedis.hget(otpKey, RETRY_COUNT_FIELD)));
			otp.setExpiresAt(ConvertorUtil.convertStringToLong(jedis.hget(otpKey, EXPIRATION_FIELD)));
			return otp;
		} else {
			throw new AppException("OTP not registered for the Email : " + email);
		}
	}

	public synchronized void removeOTP(String email) {
		String optkey = otpKey(email);
		if (jedis.exists(optkey)) {
			jedis.del(optkey);
		}
	}
}
