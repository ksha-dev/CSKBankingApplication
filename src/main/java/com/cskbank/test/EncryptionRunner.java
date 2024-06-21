	package com.cskbank.test;

import java.nio.charset.Charset;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

public class EncryptionRunner {
	private static final String ALGORITHM = "AES";
	private static final String TRANSFORMATION = "AES";
	private static final String KEY_TEXT = "abc";
	private static SecretKey KEY;
	private static final long KeySize = 10000000000000000L;

	static {
		try {
			KEY = new SecretKeySpec(
					String.format("%12s", KEY_TEXT + System.currentTimeMillis()).getBytes(Charset.forName("UTF-8")),
					ALGORITHM);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static SecretKey getKey(long key) {
		String keyText = String.format("%016d", (key % KeySize));
		return new SecretKeySpec(keyText.getBytes(), ALGORITHM);
	}

	public static void main(String[] args) throws InvalidKeyException, NoSuchAlgorithmException, NoSuchPaddingException,
			IllegalBlockSizeException, BadPaddingException {
		for (int i = 1; i <= 40; i++) {
			String s = "";
			for (int j = 1; j <= i; j++) {
				s = s + (j % 10);
			}
			System.out.println(s + " : " + encrypt(s));
		}
	}

	public static String encrypt(String value) throws NoSuchAlgorithmException, NoSuchPaddingException,
			InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
		Cipher cipher = Cipher.getInstance(TRANSFORMATION);
		cipher.init(Cipher.ENCRYPT_MODE, KEY);
		String encryptedValue = Base64.getEncoder().encodeToString(cipher.doFinal(value.getBytes()));
		return encryptedValue;
	}

	public static String encrypt(String value, SecretKey key) throws NoSuchAlgorithmException, NoSuchPaddingException,
			InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
		Cipher cipher = Cipher.getInstance(TRANSFORMATION);
		cipher.init(Cipher.ENCRYPT_MODE, key);
		String encryptedValue = Base64.getEncoder().encodeToString(cipher.doFinal(value.getBytes()));
		return encryptedValue;
	}

	public static String decrypt(String value) throws NoSuchAlgorithmException, NoSuchPaddingException,
			InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
		Cipher cipher = Cipher.getInstance(TRANSFORMATION);
		cipher.init(Cipher.DECRYPT_MODE, KEY);

		byte[] decryptedBytes = cipher.doFinal(Base64.getDecoder().decode(value));
		String decryptedText = new String(decryptedBytes);
		System.out.println(decryptedText);
		return decryptedText;
	}

	public static String decrypt(String value, SecretKey key) throws NoSuchAlgorithmException, NoSuchPaddingException,
			InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
		Cipher cipher = Cipher.getInstance(TRANSFORMATION);
		cipher.init(Cipher.DECRYPT_MODE, key);

		byte[] decryptedBytes = cipher.doFinal(Base64.getDecoder().decode(value));
		String decryptedText = new String(decryptedBytes);
		return decryptedText;
	}
}