package com.cskbank.api.mickey;

import com.adventnet.cskbank.ACCOUNT;
import com.adventnet.cskbank.TRANSACTION;
import com.adventnet.cskbank.USER;
import com.adventnet.ds.query.Column;
import com.adventnet.ds.query.Criteria;
import com.adventnet.ds.query.QueryConstants;
import com.adventnet.ds.query.UpdateQuery;
import com.adventnet.ds.query.UpdateQueryImpl;
import com.adventnet.persistence.DataAccess;
import com.adventnet.persistence.DataObject;
import com.adventnet.persistence.Row;
import com.adventnet.persistence.WritableDataObject;
import com.cskbank.exceptions.AppException;
import com.cskbank.exceptions.messages.APIExceptionMessage;
import com.cskbank.modules.Account;
import com.cskbank.modules.Transaction;
import com.cskbank.modules.UserRecord;
import com.cskbank.utility.ConstantsUtil.Status;
import com.cskbank.utility.ValidatorUtil;
import com.zoho.ear.dbencryptagent.udt.CipherTextDTTransformer;

class MickeyAPIUtil {

	static boolean updateBalanceInAccount(Account account, boolean changeStatus) throws AppException {
		ValidatorUtil.validateObject(account);

		Criteria updateBalanceCriteria = new Criteria(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.ACCOUNT_NUMBER),
				account.getAccountNumber(), QueryConstants.EQUAL);
		updateBalanceCriteria.and(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.STATUS), Status.CLOSED.getStatusID(),
				QueryConstants.NOT_EQUAL);

		try {
			UpdateQuery updateBalanceQuery = new UpdateQueryImpl(ACCOUNT.TABLE);
			updateBalanceQuery.setCriteria(updateBalanceCriteria);

//			updateBalanceQuery.setUpdateColumn(ACCOUNT.BALANCE, new CipherTextDTTransformer().transform(ACCOUNT.TABLE,
//					ACCOUNT.BALANCE, account.getBalance(), "CTEXT"));
			updateBalanceQuery.setUpdateColumn(ACCOUNT.BALANCE, account.getBalance() + "");
			updateBalanceQuery.setUpdateColumn(ACCOUNT.LAST_TRANSACTED_AT, account.getLastTransactedAt());
			updateBalanceQuery.setUpdateColumn(ACCOUNT.MODIFIED_BY, account.getModifiedBy());
			updateBalanceQuery.setUpdateColumn(ACCOUNT.MODIFIED_AT, account.getModifiedAt());
			if (changeStatus)
				updateBalanceQuery.setUpdateColumn(ACCOUNT.STATUS, Status.ACTIVE.getStatusID());

			DataAccess.update(updateBalanceQuery);
			return true;
		} catch (Exception e) {
			throw new AppException(e);
		}

	}

	static void createSenderTransactionRecord(Transaction transaction) throws AppException {
		ValidatorUtil.validateObject(transaction);

		Row senderTransactionRow = new Row(TRANSACTION.TABLE);
		senderTransactionRow.set(TRANSACTION.USER_ID, transaction.getUserId());
		senderTransactionRow.set(TRANSACTION.SENDER_ACCOUNT, transaction.getViewerAccountNumber());
		senderTransactionRow.set(TRANSACTION.RECEIVER_ACCOUNT, transaction.getTransactedAccountNumber());
		senderTransactionRow.set(TRANSACTION.AMOUNT, transaction.getTransactedAmount());
		senderTransactionRow.set(TRANSACTION.CLOSING_BALANCE, transaction.getClosingBalance());
		senderTransactionRow.set(TRANSACTION.TYPE, transaction.getTransactionType().getTransactionTypeId());
		senderTransactionRow.set(TRANSACTION.TIME_STAMP, transaction.getTimeStamp());
		senderTransactionRow.set(TRANSACTION.REMARKS, transaction.getRemarks());
		senderTransactionRow.set(TRANSACTION.CREATED_AT, transaction.getCreatedAt());
		senderTransactionRow.set(TRANSACTION.MODIFIED_BY, transaction.getModifiedBy());

		try {
			DataObject dataObject = new WritableDataObject();
			dataObject.addRow(senderTransactionRow);
			transaction.setTransactionId(
					DataAccess.add(dataObject).getFirstRow(TRANSACTION.TABLE).getLong(TRANSACTION.TRANSACTION_ID));
		} catch (Exception e) {
			throw new AppException(e);
		}
	}

	static void createReceiverTransactionRecord(Transaction receiverTransaction) throws AppException {
		ValidatorUtil.validateObject(receiverTransaction);

		Row receiverTransactionRow = new Row(TRANSACTION.TABLE);
		receiverTransactionRow.set(TRANSACTION.TRANSACTION_ID, receiverTransaction.getTransactionId());
		receiverTransactionRow.set(TRANSACTION.USER_ID, receiverTransaction.getUserId());
		receiverTransactionRow.set(TRANSACTION.SENDER_ACCOUNT, receiverTransaction.getViewerAccountNumber());
		receiverTransactionRow.set(TRANSACTION.RECEIVER_ACCOUNT, receiverTransaction.getTransactedAccountNumber());
		receiverTransactionRow.set(TRANSACTION.AMOUNT, receiverTransaction.getTransactedAmount());
		receiverTransactionRow.set(TRANSACTION.CLOSING_BALANCE, receiverTransaction.getClosingBalance());
		receiverTransactionRow.set(TRANSACTION.TYPE, receiverTransaction.getTransactionType().getTransactionTypeId());
		receiverTransactionRow.set(TRANSACTION.TIME_STAMP, receiverTransaction.getTimeStamp());
		receiverTransactionRow.set(TRANSACTION.REMARKS, receiverTransaction.getRemarks());
		receiverTransactionRow.set(TRANSACTION.CREATED_AT, receiverTransaction.getCreatedAt());
		receiverTransactionRow.set(TRANSACTION.MODIFIED_BY, receiverTransaction.getModifiedBy());

		try {
			DataObject dataObject = new WritableDataObject();
			dataObject.addRow(receiverTransactionRow);
			DataAccess.add(dataObject);
		} catch (Exception e) {
			throw new AppException(e);
		}
	}

	static void updateUserRecord(UserRecord userRecord) throws AppException {
		Row userRow = new Row(USER.TABLE);
		userRow.set(USER.USER_ID, userRecord.getUserId());
		try {
			MickeyConverstionUtil.updateUserRecord(DataAccess.get(USER.TABLE, userRow).getFirstRow(USER.TABLE),
					userRecord);
		} catch (Exception e) {
			throw new AppException(APIExceptionMessage.CANNOT_FETCH_DETAILS, e);
		}
	}

}
