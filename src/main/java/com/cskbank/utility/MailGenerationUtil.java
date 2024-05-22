package com.cskbank.utility;

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

public class MailGenerationUtil {

	private static final String FROM = "no-reply@cskbank.in";
	private static final Properties HOST_PROPERTIES = new Properties();

	static {
		HOST_PROPERTIES.put("mail.smtp.auth", "false");
		HOST_PROPERTIES.put("mail.smtp.starttls.enable", "false");
		HOST_PROPERTIES.put("mail.smtp.host", "smtp.freesmtpservers.com");
		HOST_PROPERTIES.put("mail.smtp.port", "25");
	}

	private static final Session MESSAGE_SESSION_TEST = Session.getInstance(HOST_PROPERTIES);

	public static synchronized boolean sendMail(String receipientEmail, String subject, String bodyText)
			throws AppException {
		ValidatorUtil.validateEmail(receipientEmail);
		ValidatorUtil.validateObject(subject);
		ValidatorUtil.validateObject(bodyText);
		try {
			Message message = new MimeMessage(MESSAGE_SESSION_TEST);
			message.setFrom(new InternetAddress(FROM));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(receipientEmail));
			message.setSubject(subject);
			message.setText(bodyText);
			Transport.send(message);
			System.out.println("Mail sent :" + receipientEmail + " : " + subject);
			return true;
		} catch (MessagingException e) {
			throw new AppException("OTP Mail could not be sent. Please try again");
		}
	}

	public static synchronized boolean sendVerificationOTPMail(String receipientEmail, int regenerationCount)
			throws AppException {
		ValidatorUtil.validateEmail(receipientEmail);
		OTP otp = OTP.getNewOTP(receipientEmail);
		try {
			String subject = "Verification Code";
			String bodyText = "Your one time verification code has been generated successfully and the same is \n\n"
					+ otp.getOTP()
					+ "\n\n This will expire within 5 minutes. The signup process will be invalidated and blocked "
					+ "after entering the wrong OTP for 5 consecutive times";
			return sendMail(receipientEmail, subject, bodyText);
		} catch (AppException e) {
			otp.remove();
			throw new AppException("OTP Mail could not be sent. Please try again");
		}
	}

	public static synchronized boolean sendVerificationOTPMail(String receipientMail) throws AppException {
		return sendVerificationOTPMail(receipientMail, ConstantsUtil.MAX_REGENERATION_COUNT);
	}
}
