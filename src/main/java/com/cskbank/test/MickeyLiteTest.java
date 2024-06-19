package com.cskbank.test;

import java.util.Iterator;

import com.adventnet.cskbank.USER;
import com.adventnet.persistence.DataAccess;
import com.adventnet.persistence.DataAccessException;
import com.adventnet.persistence.DataObject;
import com.adventnet.persistence.Row;
import com.adventnet.persistence.WritableDataObject;
import com.cskbank.exceptions.AppException;
import com.cskbank.modules.UserRecord.Type;
import com.cskbank.utility.ConstantsUtil.Gender;
import com.cskbank.utility.ConstantsUtil.Status;
import com.zoho.logs.logclient.v2.LogAPI;
import com.zoho.logs.logclient.v2.json.ZLMap;

public class MickeyLiteTest {

	public static void test() throws AppException {

		try {
			Row u = new Row(USER.TABLE);
			u.set(USER.FIRST_NAME, "Sharan");
			u.set(USER.LAST_NAME, "K");
			u.set(USER.DOB, 100);
			u.set(USER.GENDER, Gender.MALE.getGenderID());
			u.set(USER.ADDRESS, "Chennai");
			u.set(USER.PHONE, 9999988889L);
			u.set(USER.EMAIL, "sharan@gmail.com");
			u.set(USER.TYPE, Type.CUSTOMER.getTypeID());
			u.set(USER.STATUS, Status.ACTIVE.getStatusID());
			u.set(USER.CREATED_AT, System.currentTimeMillis());
			u.set(USER.MODIFIED_BY, 1);
			DataObject dataObject = new WritableDataObject();
			dataObject.addRow(u);
			dataObject = DataAccess.add(dataObject);

			LogAPI.log("mickey",
					new ZLMap().put("firstRow", dataObject.getFirstRow(USER.TABLE).getString(USER.FIRST_NAME)));

			Iterator it = dataObject.getRows(USER.TABLE);
			while (it.hasNext()) {
				Row row = (Row) it.next();
				LogAPI.log("mickey", new ZLMap().put(row.getInt(USER.USER_ID) + "", row.getString(USER.FIRST_NAME)));
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new AppException(e.getMessage());
		}

	}
}
