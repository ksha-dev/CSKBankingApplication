package com.cskbank.ear;

import java.io.FileInputStream;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.apache.commons.io.IOUtils;

import com.cskbank.utility.LogUtil;
import com.zoho.ear.agent.kmsagent.util.KMSAgentMaster;
import com.zoho.ear.agent.kmsagent.util.KMSAgentMasterInterface;

public class CSKBankMasterInterfaceImpl implements KMSAgentMasterInterface {

	private static final Logger LOGGER = Logger.getLogger(CSKBankMasterInterfaceImpl.class.getName());

	@Override
	public KMSAgentMaster getMasterKey() {
		KMSAgentMaster kmsAgentMaster = null;
		String serverHome = System.getProperty("server.dir");
		try {
			byte[] masterKey = IOUtils.toByteArray(new FileInputStream(serverHome + "/keys/MasterKey"));
			byte[] masterIv = IOUtils.toByteArray(new FileInputStream(serverHome + "/keys/MasterIv"));

			kmsAgentMaster = new KMSAgentMaster(masterKey, masterIv, masterKey, masterIv);
			LOGGER.log(Level.SEVERE, "KMS MasterKey : " + kmsAgentMaster.getMasterKey().toString() + ", KMS MasterIv : "
					+ kmsAgentMaster.getMasterIv().toString());

		} catch (Exception e) {
			LOGGER.log(Level.SEVERE, "Exception occured while getting MasterKey and MasterIv :: " + e.getMessage());
		}
		return kmsAgentMaster;
	}

}
