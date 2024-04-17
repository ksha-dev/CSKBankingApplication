package cache;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.Objects;

import api.UserAPI;
import exceptions.AppException;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.exceptions.JedisException;

public class RedisCache<K, V> extends Cache<K, V> {

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
		System.out.println(moduleName + key);
		// If exists, get value or fetch it from API
		byte[] cacheValue = jedis.get(keyBytes);
		System.out.println(cacheValue);

		if (cacheValue == null) {
			returnValue = super.fetchData(key);
			System.out.println(returnValue);
			this.put(key, returnValue);
		} else {
			returnValue = deserialize(cacheValue);
		}

		// Update list
//		jedis.lpush(moduleName, key.toString());
//		if (jedis.llen(moduleName) > capacity) {
//			jedis.del(jedis.rpop(moduleName).getBytes());
//		}
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
