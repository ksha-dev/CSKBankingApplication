package com.cskbank.service;

import java.io.IOException;
import java.util.Iterator;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.adventnet.ds.query.Criteria;
import com.adventnet.iam.security.antivirus.Agent;
import com.adventnet.persistence.DataAccess;
import com.adventnet.persistence.Row;
import com.adventnet.persistence.SERVICEPROPERTIES;
import com.cskbank.cache.CachePool;
import com.cskbank.cache.CachePool.CacheIdentifier;
import com.cskbank.ear.CSKBankMasterInterfaceImpl;
import com.cskbank.ear.CSKBankOrgIdImpl;
import com.cskbank.servlet.HandlerObject;
import com.cskbank.utility.ConstantsUtil;
import com.cskbank.utility.ConstantsUtil.PersistanceIdentifier;
import com.cskbank.utility.ConvertorUtil;
import com.cskbank.utility.LogUtil;
import com.zoho.ear.agent.kmsagent.util.KMSAgentConfiguration;
import com.zoho.ear.agent.kmsagent.util.KMSAgentDBInterface;
import com.zoho.ear.agent.kmsagent.util.KMSAgentKeyManagement;
import com.zoho.ear.agent.kmsagent.util.KMSAgentKeyMeta;
import com.zoho.ear.common.util.AgentConfiguration;
import com.zoho.ear.common.util.EARException;
import com.zoho.ear.dbencryptagent.DBEncryptAgent;
import com.zoho.logs.logclient.v2.LogAPI;
import com.zoho.logs.logclient.v2.json.ZLMap;

public class InitContextListener implements ServletContextListener {
	private PersistanceIdentifier persistenceIdentifier;
	private CacheIdentifier cacheIdentifier;

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		try {
			LogAPI.log("access", new ZLMap().put("message", "ContextListener Destroyed"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		try {
			Iterator<?> itr = DataAccess.get(SERVICEPROPERTIES.TABLE, (Criteria) null).getRows(SERVICEPROPERTIES.TABLE);
			while (itr.hasNext()) {
				Row property = (Row) itr.next();
				String propName = property.getString(SERVICEPROPERTIES.PROPERTY);
				String propValue = property.getString(SERVICEPROPERTIES.VALUE);

				switch (propName) {
				case "persistence":
					persistenceIdentifier = ConvertorUtil.convertToEnum(PersistanceIdentifier.class, propValue);
					break;

				case "cache":
					cacheIdentifier = ConvertorUtil.convertToEnum(CacheIdentifier.class, propValue);
					break;

				default:
					break;
				}
			}
			HandlerObject.initialize(persistenceIdentifier);
			CachePool.initializeCache(HandlerObject.getCommonHandler().getUserAPI(), cacheIdentifier);
			initClasses();

			LogAPI.log("access", new ZLMap().put("message", "ContextListener Initialized"));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void initClasses() {
		try {
			KMSAgentConfiguration.setRemoteRedisHost(ConstantsUtil.REDIS_HOST, ConstantsUtil.REDIS_PORT);
			KMSAgentConfiguration.setKMSMasterInterfaceClass(CSKBankMasterInterfaceImpl.class.getName());
			LogUtil.logString("KMS Class : " + KMSAgentConfiguration.masterInterfaceClass);

			AgentConfiguration.setStandAloneMode(true);
			DBEncryptAgent.setCommonServiceName(CSKBankService.class.getSimpleName());
			DBEncryptAgent.disableOrgID();
		} catch (EARException e) {
			LogUtil.logException(e);
		}
	}
}
