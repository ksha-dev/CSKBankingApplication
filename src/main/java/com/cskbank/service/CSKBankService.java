package com.cskbank.service;

import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.adventnet.iam.security.antivirus.Agent;
import com.adventnet.mfw.service.Service;
import com.adventnet.persistence.DataObject;
import com.adventnet.persistence.Row;
import com.adventnet.persistence.SERVICEPROPERTIES;
import com.cskbank.api.AdminAPI;
import com.cskbank.cache.CachePool;
import com.cskbank.ear.CSKBankMasterInterfaceImpl;
import com.cskbank.ear.CSKBankOrgIdImpl;
import com.cskbank.exceptions.AppException;
import com.cskbank.modules.Branch;
import com.cskbank.modules.EmployeeRecord;
import com.cskbank.modules.UserRecord.Type;
import com.cskbank.utility.ConstantsUtil.Gender;
import com.cskbank.utility.ConstantsUtil.PersistanceIdentifier;
import com.cskbank.utility.ConstantsUtil.Status;
import com.zoho.ear.agent.kmsagent.util.KMSAgentConfiguration;
import com.zoho.ear.agent.kmsagent.util.KMSAgentMaster;
import com.zoho.ear.common.util.AgentConfiguration;
import com.zoho.ear.common.util.EARException;
import com.zoho.ear.dbencryptagent.DBEncryptAgent;
import com.cskbank.utility.ConstantsUtil;
import com.cskbank.utility.ConvertorUtil;
import com.cskbank.utility.LogUtil;

public class CSKBankService implements Service {
	private static final Logger LOGGER = Logger.getLogger(CSKBankService.class.getName());
	private static PersistanceIdentifier persistanceIdentifier;
	private static AdminAPI adminAPI;

	@Override
	public void create(DataObject cskbankServiceDO) throws Exception {
		Iterator<?> it = cskbankServiceDO.getRows("ServiceProperties");
		while (it.hasNext()) {
			Row property = (Row) it.next();
			String propName = property.getString(SERVICEPROPERTIES.PROPERTY);
			String propValue = property.getString(SERVICEPROPERTIES.VALUE);
			if (propName.equals("persistence"))
				persistanceIdentifier = ConvertorUtil.convertToEnum(PersistanceIdentifier.class, propValue);
		}
		if (persistanceIdentifier == null) {
			throw new AppException(
					"Persistence or Cache Identifier not specified in the properties of service.xml of the module");
		}
		LOGGER.log(Level.FINER, "cskbankservice.createService invoked");
	}

	@Override
	public void destroy() throws Exception {
		LOGGER.log(Level.FINER, "cskbankservice.destroyService invoked");
	}

	@Override
	public void start() throws Exception {
		@SuppressWarnings("unchecked")
		Class<AdminAPI> persistanceClass = (Class<AdminAPI>) Class.forName("com.cskbank.api."
				+ persistanceIdentifier.toString().toLowerCase() + "." + persistanceIdentifier.toString() + "AdminAPI");

		adminAPI = persistanceClass.getConstructor().newInstance();

		initClasses();
		int userId = adminAPI.isDBInitialized();

		if (userId < 1) {
			CachePool.clearRedisDB();
			initDB();
		} else {
			adminAPI.getUserDetails(userId);
		}
	}

	private void initClasses() throws EARException {
//		DBEncryptAgent.setEAROrgIdInterface(CSKBankOrgIdImpl.class.getName());
		KMSAgentConfiguration.setRemoteRedisHost(ConstantsUtil.REDIS_HOST, ConstantsUtil.REDIS_PORT);
		KMSAgentConfiguration.setKMSMasterInterfaceClass(CSKBankMasterInterfaceImpl.class.getName());
		AgentConfiguration.setStandAloneMode(true);
		DBEncryptAgent.setCommonServiceName(CSKBankService.class.getSimpleName());
		DBEncryptAgent.disableOrgID();
		LOGGER.log(Level.SEVERE, KMSAgentConfiguration.masterInterfaceClass);
//		DBEncryptAgent.setEAROrgIdInterface(CSKBankOrgIdImpl.class.getName());
	}

	private void initDB() throws AppException {
		EmployeeRecord admin = new EmployeeRecord();
		admin.setFirstName("Admin");
		admin.setLastName("User");
		admin.setDateOfBirth(946665000000L);
		admin.setGender(Gender.OTHER);
		admin.setAddress("CSK BANK");
		admin.setEmail("admin@cskbank.in");
		admin.setPhone(9000000000L);
		admin.setType(Type.ADMIN);
		admin.setStatus(Status.ACTIVE);
		admin.setCreatedAt(System.currentTimeMillis());
		admin.setModifiedBy(1);

		adminAPI.createUserRecord(admin);

		admin.setModifiedBy(admin.getUserId());

		Branch branch = new Branch();
		branch.setAccountsCount(0);
		branch.setAddress("CSK Head Branch");
		branch.setPhone(9000090000L);
		branch.setEmail("head@cskbank.in");
		branch.setModifiedBy(admin.getUserId());
		branch.setCreatedAt(System.currentTimeMillis());

		adminAPI.createBranch(branch);

		admin.setBranchId(branch.getBranchId());

		adminAPI.addEmployeeRecord(admin);
		LOGGER.log(Level.FINER, "cskbankservice.startService invoked");
	}

	@Override
	public void stop() throws Exception {
		LOGGER.log(Level.FINER, "cskbankservice.stopService invoked");
	}

}
