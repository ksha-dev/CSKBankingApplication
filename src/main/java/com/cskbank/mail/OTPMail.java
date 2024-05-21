package com.cskbank.mail;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.cskbank.exceptions.AppException;
import com.cskbank.modules.OTP;
import com.cskbank.servlet.Services;
import com.cskbank.utility.ConstantsUtil;
import com.cskbank.utility.ConvertorUtil;
import com.cskbank.utility.ValidatorUtil;

public class OTPMail {

	private static final String FROM = "no-reply@cskbank.in";
//	private static final String SERVICE_USERNAME = "api";
//	private static final String SERVICE_PASSWORD = "848a4d4b43cb49fb87cc9d5445480b38";
	private static final Properties HOST_PROPERTIES = new Properties();

	static {
//		HOST_PROPERTIES.put("mail.smtp.auth", "true");
//		HOST_PROPERTIES.put("mail.smtp.starttls.enable", "true");
//		HOST_PROPERTIES.put("mail.smtp.host", "live.smtp.mailtrap.io");
//		HOST_PROPERTIES.put("mail.smtp.port", "587");

		HOST_PROPERTIES.put("mail.smtp.auth", "false");
		HOST_PROPERTIES.put("mail.smtp.starttls.enable", "false");
		HOST_PROPERTIES.put("mail.smtp.host", "smtp.freesmtpservers.com");
		HOST_PROPERTIES.put("mail.smtp.port", "25");
	}

//	private static final Session MESSAGE_SESSION = Session.getInstance(HOST_PROPERTIES, new Authenticator() {
//		protected PasswordAuthentication getPasswordAuthentication() {
//			return new PasswordAuthentication(SERVICE_USERNAME, SERVICE_PASSWORD);
//		}
//	});

	private static final Session MESSAGE_SESSION_TEST = Session.getInstance(HOST_PROPERTIES);

	public static synchronized boolean generateOTPMail(String receipientEmail, int regenerationCount)
			throws AppException {
		ValidatorUtil.validateEmail(receipientEmail);
		int otp = ConvertorUtil.randomOTPGenerator();
		try {
			Message message = new MimeMessage(MESSAGE_SESSION_TEST);
			message.setFrom(new InternetAddress(FROM));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(receipientEmail));
			message.setSubject("Verification Code");
			message.setText("Your one time verification code has been generated successfully and the same is \n\n"
					+ String.format("%6d", otp)
					+ "\n\n This will expire within 5 minutes. The signup process will be invalidated and blocked "
					+ "after entering the wrong OTP for 5 consecutive times");
			Transport.send(message);

			OTP otpObj = new OTP();
			otpObj.setOTP(otp + "");
			otpObj.setEmail(receipientEmail);
			otpObj.setExpiresAt(System.currentTimeMillis() + ConstantsUtil.EXPIRY_DURATION);
			otpObj.setRetryCount(ConstantsUtil.MAX_RETRY_COUNT);
			otpObj.setRegenerationCount(regenerationCount);

			System.out.println("OTP sent to " + receipientEmail + " : " + otp);

			Services.otpDatabase.setOTP(otpObj);
			return true;
		} catch (MessagingException e) {
			throw new AppException("OTP Mail could not be sent. Please try again");
		}
	}

	public static synchronized boolean generateOTPMail(String receipientMail) throws AppException {
		return generateOTPMail(receipientMail, ConstantsUtil.MAX_REGENERATION_COUNT);
	}

	public static void main(String[] args) {
		try {
			generateOTPMail("ksha1933@outlook.in");
			System.out.println("Mail Delivered");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
