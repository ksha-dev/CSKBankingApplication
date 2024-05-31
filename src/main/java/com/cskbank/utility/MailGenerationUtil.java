package com.cskbank.utility;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.cskbank.exceptions.AppException;
import com.cskbank.modules.OTP;
import com.cskbank.modules.UserRecord;

public class MailGenerationUtil {

	private static final String FROM = "no-reply@cskbank.in";
	private static final Properties HOST_PROPERTIES = new Properties();
	private static final String USER_NAME = "";
	private static final String PASSWORD = "";

	public static final Authenticator AUTH = new Authenticator() {
		@Override
		protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(USER_NAME, PASSWORD);
		}
	};

	static {
		HOST_PROPERTIES.put("mail.smtp.auth", "false");
		HOST_PROPERTIES.put("mail.smtp.starttls.enable", "false");
		HOST_PROPERTIES.put("mail.smtp.host", "smtp.freesmtpservers.com");
		HOST_PROPERTIES.put("mail.smtp.port", "25");
	}

	private static final Session MAIL_SESSION = Session.getInstance(HOST_PROPERTIES);

	public static synchronized boolean sendMail(String receipientEmail, String subject, String bodyText)
			throws AppException {
		ValidatorUtil.validateEmail(receipientEmail);
		ValidatorUtil.validateObject(subject);
		ValidatorUtil.validateObject(bodyText);
		try {
			Message message = new MimeMessage(MAIL_SESSION);
			message.setFrom(new InternetAddress(FROM));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(receipientEmail));
			message.setSubject(subject);
			message.setText(bodyText);
			Transport.send(message);
			System.out.println("Mail sent :" + receipientEmail + " : " + subject);
			return true;
		} catch (MessagingException e) {
			throw new AppException("Mail could not be sent. Please try again");
		}
	}

	public static synchronized boolean sendVerificationOTPMail(String receipientEmail, int regenerationCount)
			throws AppException {
		ValidatorUtil.validateEmail(receipientEmail);
		OTP otp = OTP.getNewOTP(receipientEmail, regenerationCount);
		System.out.println(regenerationCount);
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

	public static boolean sendUserSignupMail(UserRecord user) throws AppException {
		String subject = "CSK Bank - User Signup";
		String bodyText = "Hello " + user.getFirstName()
				+ ",\n\nThank you for signing up with up. Your user record has been created. "
				+ "Please follow the instructions to login to our application." + "\n\nUser ID : " + user.getUserId()
				+ "\nPassword : <First 4 letters of your first name>@<Date of birth in MMDD format>"
				+ "\nExample : If your name is Ramesh and you were born on August 20, your password will be Rame@0820"
				+ "\n\nAn authorization PIN has been set for your account and it is the last 4 digits of your phone number\n"
				+ "\n\nLogin URL : https://localhost:8443/CSKBankingApplication/login" + "\n\nTeam CSKBank.";
		return sendMail(user.getEmail(), subject, bodyText);
	}

	public static boolean sendUserCreationMail(UserRecord user) throws AppException {
		String subject = "CSK Bank - User Registration";
		String bodyText = "Hello " + user.getFirstName()
				+ ",\n\nThank you for signing up with CSK Bank. Your user record has been created. "
				+ "Please follow the instructions to login to our application." + "\n\nUser ID : " + user.getUserId()
				+ "\nPassword : <First 4 letters of your first name>@<Date of birth in MMDD format>"
				+ "\nExample : If your name is Ramesh and you were born on August 20, your password will be Rame@0820"
				+ "\n\nAn authorization PIN has been set for your account and it is the last 4 digits of your phone number\n"
				+ "\n\nLogin URL : https://localhost:8443/CSKBankingApplication/login \n\nTeam CSKBank.";
		return sendMail(user.getEmail(), subject, bodyText);
	}

	public static boolean sendPasswordResetMail(String receipientEmail, String link) throws AppException {
		ValidatorUtil.validateEmail(receipientEmail);
		ValidatorUtil.validateObject(link);
		String subject = "CSK Bank - Password Reset";
		String bodyText = "This is you password reset link:\n\n" + link;
		return sendMail(receipientEmail, subject, bodyText);
	}
}
