package com.cskbank.handlers;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.util.Base64;

import javax.imageio.ImageIO;

import com.cskbank.utility.SecurityUtil;

import nl.captcha.Captcha;
import nl.captcha.backgrounds.GradiatedBackgroundProducer;
import nl.captcha.noise.CurvedLineNoiseProducer;

public class CaptchaHandler {

	public static String getCaptchaString() {
		String captcha = SecurityUtil.getRandomString(6);
		System.out.println("Captcha String :" + captcha);
		return captcha;
	}

	public static String getCaptchaImageByteString() {
		String captchaEncodedString = "";
		try {
			Captcha captcha = new Captcha.Builder(200, 50).addText(() -> getCaptchaString())
					.addBackground(new GradiatedBackgroundProducer()).addNoise(new CurvedLineNoiseProducer())
					.addBorder().build();
			BufferedImage image = captcha.getImage();
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			ImageIO.write(image, "png", baos);
			captchaEncodedString = Base64.getEncoder().encodeToString(baos.toByteArray());
			System.out.println("Captcha Image : " + captchaEncodedString);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return captchaEncodedString;
	}
}
