package com.cskbank.cache;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

import com.cskbank.api.UserAPI;
import com.cskbank.exceptions.AppException;

import redis.clients.jedis.Jedis;

class RedisCache<K, V> extends Cache<K, V> {

	private static final String HOST_NAME = "localhost";
	private static final int PORT = 6379;
	private Jedis jedis;

	public RedisCache(UserAPI api, int capacity, String moduleName) {
		super(api, capacity, moduleName);
		jedis = new Jedis(HOST_NAME, PORT);
	}

	@Override
	public final V get(K key) throws AppException {
		byte[] keyBytes = (moduleName + key).getBytes();
		V returnValue;
		byte[] cacheValue = jedis.get(keyBytes);

		if (cacheValue == null) {
			returnValue = super.fetchData(key);
			this.put(key, returnValue);
		} else {
			returnValue = deserialize(cacheValue);
		}
		return returnValue;
	}

	@Override
	protected void put(K key, V value) {
		byte[] keyBytes = (moduleName + key).getBytes();
		jedis.set(keyBytes, serialize(value));
	}

	@Override
	public void clear() {
		jedis.flushDB();
	}

	private final byte[] serialize(Object object) {
		byte[] returnByte = null;
		try (ByteArrayOutputStream out = new ByteArrayOutputStream();
				ObjectOutputStream os = new ObjectOutputStream(out)) {
			os.writeObject(object);
			returnByte = out.toByteArray();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return returnByte;
	}

	@SuppressWarnings("unchecked")
	private final V deserialize(byte[] bytes) {
		V returnObject = null;
		try (ByteArrayInputStream in = new ByteArrayInputStream(bytes);
				ObjectInputStream os = new ObjectInputStream(in)) {
			returnObject = (V) os.readObject();
		} catch (IOException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return returnObject;
	}
}
