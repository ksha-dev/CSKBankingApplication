package cache;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;

import exceptions.AppException;

public abstract class LRUCache<K, V> extends Cache<K, V> {

	private int capacity;
	private Map<K, V> cacheData;
	private LinkedList<K> cacheKeyOrder;

	protected LRUCache(int capacity) {
		this.capacity = capacity;
		cacheData = new HashMap<K, V>();
		cacheKeyOrder = new LinkedList<K>();
	}

	public final V get(K key) throws AppException {

		if (cacheData.containsKey(key)) {
			cacheKeyOrder.remove(key);
			cacheKeyOrder.addFirst(key);
			return cacheData.get(key);
		} else {
			V value = fetchData(key);
			put(key, value);
			return value;
		}
	}

	protected final void put(K key, V val) {
		if (cacheKeyOrder.contains(key)) {
			cacheKeyOrder.remove(key);
		}
		if (cacheKeyOrder.size() >= capacity) {
			K keyRemoved = cacheKeyOrder.removeLast();
			cacheData.remove(keyRemoved);
		}
		cacheKeyOrder.addFirst(key);
		cacheData.put(key, val);
	}

	public final void clear() {
		cacheData.clear();
		cacheKeyOrder.clear();
	}

	protected abstract V fetchData(K key) throws AppException;
}
