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

	public final V fetchData(K key) throws AppException {
		V returnValue = null;
		try {
			UserAPI.class.getMethod("get" + moduleName + "Details", int.class).invoke(api, key);
		} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException | NoSuchMethodException
				| SecurityException e) {
			throw new AppException("Cache Layer Failed");
		}
		return returnValue;
	}

	public final V refreshData(K key) throws AppException {
		V value = fetchData(key);
		put(key, value);
		return value;
	}
}
