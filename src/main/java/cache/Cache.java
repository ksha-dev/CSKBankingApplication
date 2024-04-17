package cache;

import java.lang.reflect.InvocationTargetException;

import api.UserAPI;
import exceptions.AppException;

public abstract class Cache<K, V> {
	protected UserAPI api;
	protected int capacity;
	protected String moduleName;

	protected Cache(UserAPI api, int capacity, String moduleName) {
		this.api = api;
		this.capacity = capacity;
		this.moduleName = moduleName;
	}

	public abstract V get(K key) throws AppException;

	public abstract void clear();

	protected abstract void put(K key, V value);

	@SuppressWarnings("unchecked")
	public final V fetchData(K key) throws AppException {
		try {
			System.out.println("get" + moduleName + "Details");
			return (V) UserAPI.class.getDeclaredMethod("get" + moduleName + "Details", key.getClass()).invoke(api, key);
		} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException | NoSuchMethodException
				| SecurityException e) {
			e.printStackTrace();
			throw new AppException("Cache Layer Failed");
		}
	}

	public final V refreshData(K key) throws AppException {
		V value = fetchData(key);
		put(key, value);
		return value;
	}
}
