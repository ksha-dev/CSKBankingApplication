package com.cskbank.service;

import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.adventnet.mfw.service.Service;
import com.adventnet.persistence.DataObject;
import com.cskbank.utility.ConstantsUtil.PersistanceIdentifier;
import com.cskbank.cache.CachePool;
import com.cskbank.cache.CachePool.CacheIdentifier;
import com.cskbank.servlet.HandlerObject;
import com.cskbank.utility.GetterUtil;

public class CSKBankService implements Service {
	private static final Logger LOGGER = Logger.getLogger(CSKBankService.class.getName());
	private static PersistanceIdentifier persistanceIdentifier;
	private static CacheIdentifier cacheIdentifier;

	@Override
	public void create(DataObject arg0) throws Exception {
		Properties appProperties = GetterUtil.loadPropertiesFile("app.properties");
		persistanceIdentifier = PersistanceIdentifier.valueOf(appProperties.getProperty("persistence"));
		cacheIdentifier = CacheIdentifier.valueOf(appProperties.getProperty("cache"));

		LOGGER.log(Level.FINER, "cskbankservice.createService invoked");
	}

	@Override
	public void destroy() throws Exception {
		LOGGER.log(Level.FINER, "cskbankservice.destroyService invoked");
	}

	@Override
	public void start() throws Exception {
		HandlerObject.initialize(persistanceIdentifier);
		CachePool.initializeCache(HandlerObject.commonHandler.getUserAPI(), cacheIdentifier);

		LOGGER.log(Level.FINER, "cskbankservice.startService invoked");
	}

	@Override
	public void stop() throws Exception {
		LOGGER.log(Level.FINER, "cskbankservice.stopService invoked");
	}

}
