package com.cskbank.api.mickey;

import java.sql.Connection;
import java.sql.SQLException;

import com.adventnet.db.api.RelationalAPI;
import com.cskbank.utility.LogUtil;

class MickeyConstants {

	private static final RelationalAPI RELATIONAL_API = RelationalAPI.getInstance();
	private static final Connection CONNECTION;

	static {
		Connection connection = null;
		try {
			connection = RELATIONAL_API.getConnection();
		} catch (SQLException e) {
			LogUtil.logException(e);
		}
		CONNECTION = connection;
	}

	static RelationalAPI getRAPI() {
		return RELATIONAL_API;
	}

	static Connection getRAPIConnection() {
		return CONNECTION;
	}

}
