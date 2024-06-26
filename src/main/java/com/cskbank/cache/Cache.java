package com.cskbank.cache;

import java.lang.reflect.InvocationTargetException;

import com.cskbank.api.UserAPI;
import com.cskbank.exceptions.AppException;
import com.cskbank.exceptions.messages.ActivityExceptionMessages;

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
			return (V) api.getClass().getDeclaredMethod("get" + moduleName + "Details", key.getClass()).invoke(api,
					key);
		} catch (InvocationTargetException me) {
			throw new AppException(me);
		} catch (IllegalAccessException | IllegalArgumentException | NoSuchMethodException | SecurityException e) {
			throw new AppException(ActivityExceptionMessages.FAILED_TO_LOAD_FROM_CACHE, e);
		}
	}

	public final V refreshData(K key) throws AppException {
		V value = fetchData(key);
		put(key, value);
		return value;
	}

	public abstract void remove(K key);
}
