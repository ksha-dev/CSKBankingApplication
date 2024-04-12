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

public abstract class RedisCache<K, V> extends Cache<K, V> {

	private static final String HOST_NAME = "localhost";
	private static final int PORT = 6379;
	private Jedis jedis;

	public RedisCache(UserAPI api, int capacity, String moduleName) {
		super(api, capacity, moduleName);
		jedis = new Jedis(HOST_NAME, PORT);
	}

	@Override
	public final V get(K key) throws AppException {
		byte[] keyBytes = key.toString().getBytes();
		V returnValue;

		// If exists, get value or fetch it from API
		if (jedis.exists(keyBytes)) {
			returnValue = deserialize(jedis.get(keyBytes));
		} else {
			returnValue = fetchData(key);
			jedis.set(keyBytes, serialize(returnValue));
		}

		// Update list
		jedis.lpush(moduleName, key.toString());
		if (jedis.llen(moduleName) > capacity) {
			jedis.del(jedis.rpop(moduleName).getBytes());
		}
		return returnValue;
	}

	@Override
	protected void put(K key, V value) {
		byte[] keyBytes = key.toString().getBytes();
		try {
			jedis.set(keyBytes, serialize(value));
		} catch (AppException e) {
		}
	}

	@Override
	public void clear() {
		jedis.flushDB();
	}

	private final byte[] serialize(Object object) throws AppException {
		try (ByteArrayOutputStream out = new ByteArrayOutputStream();
				ObjectOutputStream os = new ObjectOutputStream(out)) {
			os.writeObject(object);
			return out.toByteArray();
		} catch (IOException e) {
			throw new AppException();
		}
	}

	@SuppressWarnings("unchecked")
	private final V deserialize(byte[] bytes) throws AppException {
		try (ByteArrayInputStream in = new ByteArrayInputStream(bytes);
				ObjectInputStream os = new ObjectInputStream(in)) {
			return (V) os.readObject();
		} catch (IOException | ClassNotFoundException e) {
			throw new AppException();
		}
	}
}
