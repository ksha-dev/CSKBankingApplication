package cache;

import java.util.Objects;

import api.UserAPI;
import exceptions.AppException;
import modules.Account;
import modules.Branch;
import modules.UserRecord;
import utility.ValidatorUtil;

public class CachePool {
	private static UserAPI userAPI;
	private static Cache<Integer, UserRecord> userRecordCache;
	private static Cache<Long, Account> accountCache;
	private static Cache<Integer, Branch> branchCache;

	public static enum CacheIdentifier {
		Redis, LRU
	}

	private static void validateAPI() throws AppException {
		if (Objects.isNull(userAPI)) {
			throw new AppException("Cache has not been initialized");
		}
	}

	private CachePool() {
	}

	@SuppressWarnings("unchecked")
	public static void initializeCache(UserAPI userAPI, CacheIdentifier identifier) throws AppException {
		if (Objects.isNull(CachePool.userAPI)) {
			synchronized (CachePool.class) {
				if (Objects.isNull(CachePool.userAPI)) {
					ValidatorUtil.validateObject(userAPI);
					CachePool.userAPI = userAPI;
					try {
						userRecordCache = (Cache<Integer, UserRecord>) Class.forName("cache." + identifier + "Cache")
								.getDeclaredConstructor(UserAPI.class, int.class, String.class)
								.newInstance(userAPI, 10, UserRecord.class.getSimpleName());

						accountCache = (Cache<Long, Account>) Class.forName("cache." + identifier + "Cache")
								.getDeclaredConstructor(UserAPI.class, int.class, String.class)
								.newInstance(userAPI, 10, Account.class.getSimpleName());

						branchCache = (Cache<Integer, Branch>) Class.forName("cache." + identifier + "Cache")
								.getDeclaredConstructor(UserAPI.class, int.class, String.class)
								.newInstance(userAPI, 10, Branch.class.getSimpleName());

					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

				}
			}
		}
	}

	public static Cache<Integer, UserRecord> getUserRecordCache() throws AppException {
		validateAPI();
		return userRecordCache;
	}

	public static Cache<Long, Account> getAccountCache() throws AppException {
		validateAPI();
		return accountCache;
	}

	public static Cache<Integer, Branch> getBranchCache() throws AppException {
		validateAPI();
		return branchCache;
	}
}
