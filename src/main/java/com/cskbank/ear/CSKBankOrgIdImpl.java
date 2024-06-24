package com.cskbank.ear;

import com.zoho.ear.dbencryptagent.EAROrgIdInterface;

public class CSKBankOrgIdImpl implements EAROrgIdInterface {

	@Override
	public long getOrgId() {
		return 1;
	}
}
