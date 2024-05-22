package com.cskbank.utility;

import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.format.DateTimeFormatter;
import java.util.Base64;
import java.util.Random;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import com.cskbank.exceptions.AppException;
import com.cskbank.exceptions.messages.ActivityExceptionMessages;
import com.cskbank.modules.UserRecord;

public class SecurityUtil {
	static final int API_KEY_LENGTH = 40;
	static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	private static final String ALGORITHM = "AES";
	private static final String TRANSFORMATION = "AES";
	private static final String KEY_TEXT = "CSKBankingApp000";
	private static final SecretKey KEY = new SecretKeySpec(KEY_TEXT.getBytes(), ALGORITHM);

	public static String encryptPasswordSHA256(String password) {
		try {
			final MessageDigest digest = MessageDigest.getInstance("SHA-256");
			final byte[] hash = digest.digest(password.getBytes("UTF-8"));
			final StringBuilder hexString = new StringBuilder();
			for (int i = 0; i < hash.length; i++) {
				final String hex = Integer.toHexString(0xff & hash[i]);
				if (hex.length() == 1)
					hexString.append('0');
				hexString.append(hex);
			}
			return hexString.toString();
		} catch (Exception ex) {
		}
		return null;
	}

	public static String generateAPIKey() throws AppException {
		return SecurityUtil.getRandomString(API_KEY_LENGTH);
	}

	static String getRandomString(int length) {
		Random random = new Random();
		StringBuilder sb = new StringBuilder(length);

		for (int i = 0; i < length; i++) {
			int randomIndex = random.nextInt(CHARACTERS.length());
			char randomChar = CHARACTERS.charAt(randomIndex);
			sb.append(randomChar);
		}

		return sb.toString();
	}

	public static String generatePIN(UserRecord user) throws AppException {
		ValidatorUtil.validateObject(user);
		return encryptPasswordSHA256(String.format("%04d", user.getPhone() % 10000));
	}

	public static String passwordGenerator(UserRecord user) throws AppException {
		ValidatorUtil.validateObject(user);
		return encryptPasswordSHA256(user.getFirstName().substring(0, 4) + "@"
				+ user.getDateOfBirthInLocalDate().format(DateTimeFormatter.BASIC_ISO_DATE).substring(4, 8));
	}

	private static synchronized String encrypt(String value) throws NoSuchAlgorithmException, NoSuchPaddingException,
			InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
		Cipher cipher = Cipher.getInstance(TRANSFORMATION);
		cipher.init(Cipher.ENCRYPT_MODE, KEY);
		String encryptedValue = Base64.getEncoder().encodeToString(cipher.doFinal(value.getBytes()));
		return encryptedValue;
	}

	private static synchronized String decrypt(String value) throws NoSuchAlgorithmException, NoSuchPaddingException,
			InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
		Cipher cipher = Cipher.getInstance(TRANSFORMATION);
		cipher.init(Cipher.DECRYPT_MODE, KEY);

		byte[] decryptedBytes = cipher.doFinal(Base64.getDecoder().decode(value));
		String decryptedText = new String(decryptedBytes);
		return decryptedText;
	}

	public static String encryptText(String plainText) throws AppException {
		try {
			return encrypt(plainText);
		} catch (Exception e) {
			throw new AppException(ActivityExceptionMessages.ENCRYPTION_FAILED);
		}
	}

	public static String decryptCipher(String cipherText) throws AppException {
		try {
			return decrypt(cipherText);
		} catch (Exception e) {
			throw new AppException(ActivityExceptionMessages.DECRYPTION_FAILED);
		}
	}

}
