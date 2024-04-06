package utility;

import java.security.MessageDigest;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

import exceptions.AppException;
import modules.UserRecord;

public class ConvertorUtil {

	public static String passwordHasher(String password) {
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

	public static ZonedDateTime convertLongZonedDateTime(long dateTime) {
		return ZonedDateTime.ofInstant(Instant.ofEpochMilli(dateTime), ZoneId.systemDefault());
	}

	public static LocalDate convertLongToLocalDate(long dateTime) {
		return LocalDate.ofInstant(Instant.ofEpochMilli(dateTime), ZoneId.systemDefault());
	}

	public static long convertToMilliSeconds(ZonedDateTime dateTime) throws AppException {
		ValidatorUtil.validateObject(dateTime);
		return dateTime.toInstant().toEpochMilli();
	}

	public static String formatToDate(long dateTime) {
		return convertLongToLocalDate(dateTime).format(DateTimeFormatter.ofPattern("dd-MM-yyyy"));
	}

	public static String formatToUTCDate(long dateTime) {
		return convertLongToLocalDate(dateTime).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
	}

	public static String passwordGenerator(UserRecord user) throws AppException {
		ValidatorUtil.validateObject(user);
		return passwordHasher(user.getFirstName().substring(0, 4) + "@"
				+ user.getDateOfBirthInLocalDate().format(DateTimeFormatter.BASIC_ISO_DATE).substring(4, 8));
	}

	public static String pinGenerator(UserRecord user) throws AppException {
		ValidatorUtil.validateObject(user);
		return passwordHasher(String.format("%04d", user.getPhone() % 10000));
	}

	public static String ifscGenerator(int branchId) throws AppException {
		ValidatorUtil.validateId(branchId);
		return String.format("CSKB0%06d", branchId);
	}

	public static int convertPageToOffset(int pageNumber) throws AppException {
		ValidatorUtil.validateId(pageNumber);
		return (pageNumber - 1) * ConstantsUtil.LIST_LIMIT;
	}

	public static String hiddenDate(long dateTime) {
		StringBuffer date = new StringBuffer(formatToDate(dateTime));
		int[] hideIndex = { 1, 3, 4, 8, 9 };
		for (int i : hideIndex) {
			date.replace(i, i + 1, "*");
		}
		return date.toString();
	}

	public static String hiddenEmail(String email) {
		StringBuffer hiddenEmail = new StringBuffer(email);
		hiddenEmail.replace(1, email.indexOf('@'), "*".repeat(10));
		return hiddenEmail.toString();
	}

	public static String hiddenAadhar(long aadhar) {
		StringBuffer hiddenAadhar = new StringBuffer(aadhar + "");
		hiddenAadhar.replace(0, 8, "*".repeat(8));
		return hiddenAadhar.toString();
	}

	public static String hiddenPAN(String pan) {
		StringBuffer hiddenPAN = new StringBuffer(pan);
		hiddenPAN.replace(2, 8, "*".repeat(8));
		return hiddenPAN.toString();
	}

	public static String hiddenPhone(long phone) {
		StringBuffer hiddenPhone = new StringBuffer(phone + "");
		hiddenPhone.replace(0, 7, "*".repeat(6));
		return hiddenPhone.toString();
	}

	public static long dateStringToMillis(String date) throws AppException {
		ValidatorUtil.validateObject(date);
		return LocalDate.parse(date).atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli();
	}

	public static long dateStringToMillisWithCurrentTime(String date) throws AppException {
		ValidatorUtil.validateObject(date);
		LocalDate convertedDate = LocalDate.parse(date);
		if (convertedDate.isBefore(LocalDate.now(ZoneId.systemDefault()))) {
			return convertedDate.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli() + 86400000L - 1;
		} else {
			return ZonedDateTime.of(LocalDate.parse(date), LocalTime.now(), ZoneId.systemDefault()).toInstant()
					.toEpochMilli();
		}
	}

	public static double convertToTwoDecimals(double decimalNumber) {
		DecimalFormat formatter = new DecimalFormat("#.##");
		return Double.parseDouble(formatter.format(decimalNumber));
	}

	public static String displayTwoDecimals(double decimalNumber) {
		return String.format("%.2f", decimalNumber);
	}

	public static String amountToCurrencyFormat(double amount) {
		Locale localeIndia = new Locale("en", "IN");
		NumberFormat currencyFormatterIndia = NumberFormat.getCurrencyInstance(localeIndia);
		return currencyFormatterIndia.format(amount);
	}
}
