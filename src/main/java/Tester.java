import java.lang.reflect.Method;

import api.UserAPI;

public class Tester {
	public static void main(String[] args) throws NoSuchMethodException, SecurityException {
		System.out.println(UserAPI.class);

		Method[] methods = UserAPI.class.getMethods();

		for (Method method : methods) {
			System.out.println(method.getName());
			Class<?>[] parameters = method.getParameterTypes();
			for (Class classes : parameters) {
				System.out.println(classes.getName());
			}
		}

		Method method = UserAPI.class.getMethod("getUserDetails", int.class);

		System.out.println(method);
	}
}
