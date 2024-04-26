import java.lang.reflect.Method;

import api.UserAPI;
import exceptions.AppException;

public class Tester {
	public static void main(String[] args) throws Exception {
//		System.out.println(UserAPI.class);
//
//		Method[] methods = UserAPI.class.getMethods();
//
//		for (Method method : methods) {
//			System.out.println(method.getName());
//			Class<?>[] parameters = method.getParameterTypes();
//			for (Class classes : parameters) {
//				System.out.println(classes.getName());
//			}
//		}
//
//		Method method = UserAPI.class.getMethod("getUserDetails", int.class);
//
//		System.out.println(method);
		int a = 1 / 0;

		try {
//			throw new AppException("Test Exception");
			int i = 1 / 3;
		} catch (ArithmeticException e) {
//			e.printStackTrace();
			System.out.println("Hello");
		}
	}
}
