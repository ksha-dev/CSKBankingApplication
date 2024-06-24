package com.cskbank.api.mysql;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.cskbank.api.AdminAPI;
import com.cskbank.api.mysql.MySQLQuery.Column;
import com.cskbank.api.mysql.MySQLQuery.Schemas;
import com.cskbank.exceptions.AppException;
import com.cskbank.exceptions.messages.APIExceptionMessage;
import com.cskbank.modules.APIKey;
import com.cskbank.modules.Account;
import com.cskbank.modules.Branch;
import com.cskbank.modules.EmployeeRecord;
import com.cskbank.utility.ConstantsUtil;
import com.cskbank.utility.ConstantsUtil.ModifiableField;
import com.cskbank.utility.ConvertorUtil;
import com.cskbank.utility.GetterUtil;
import com.cskbank.utility.LogUtil;
import com.cskbank.utility.ValidatorUtil;

public class MySQLAdminAPI extends MySQLEmployeeAPI implements AdminAPI {

	@Override
	public boolean createEmployee(EmployeeRecord employee) throws AppException {
		ValidatorUtil.validateObject(employee);
		try {
			ServerConnection.startTransaction();
			createUserRecord(employee);

			MySQLQuery queryBuilder = new MySQLQuery();
			queryBuilder.insertInto(Schemas.EMPLOYEES);
			queryBuilder.insertValuePlaceholders(2);
			queryBuilder.end();

			PreparedStatement statement = ServerConnection.getServerConnection()
					.prepareStatement(queryBuilder.getQuery());
			statement.setInt(1, employee.getUserId());
			statement.setInt(2, employee.getBranchId());
			int response = statement.executeUpdate();
			statement.close();
			if (response == 1) {
				ServerConnection.endTransaction();
				return true;
			} else {
				throw new AppException(APIExceptionMessage.USER_CREATION_FAILED);
			}
		} catch (SQLException e) {
			ServerConnection.reverseTransaction();
			throw new AppException(e);
		}
	}

	@Override
	public void addEmployeeRecord(EmployeeRecord employee) throws AppException {
		ValidatorUtil.validateObject(employee);
		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.insertInto(Schemas.EMPLOYEES);
		queryBuilder.insertValuePlaceholders(2);
		queryBuilder.end();
		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			statement.setInt(1, employee.getUserId());
			statement.setInt(2, employee.getBranchId());
			statement.executeUpdate();
		} catch (SQLException e) {
			throw new AppException(e);
		}
	}

	@Override
	public boolean updateEmployeeDetails(int employeeId, ModifiableField field, Object value, int adminId)
			throws AppException {
		ValidatorUtil.validateId(employeeId);
		ValidatorUtil.validateId(adminId);
		ValidatorUtil.validateObject(value);
		ValidatorUtil.validateObject(field);

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.update(Schemas.EMPLOYEES);
		queryBuilder.setColumn(Column.valueOf(field.toString()));
		queryBuilder.separator();
		queryBuilder.columnEquals(Column.MODIFIED_BY);
		queryBuilder.separator();
		queryBuilder.columnEquals(Column.MODIFIED_AT);
		queryBuilder.where();
		queryBuilder.columnEquals(Column.USER_ID);
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			statement.setObject(1, value);
			statement.setInt(2, adminId);
			statement.setLong(3, System.currentTimeMillis());
			statement.setInt(4, employeeId);
			int response = statement.executeUpdate();
			if (response == 1) {
				return true;
			} else {
				throw new AppException(APIExceptionMessage.UPDATE_FAILED);
			}
		} catch (SQLException e) {
			throw new AppException(APIExceptionMessage.UNKNOWN_USER_OR_BRANCH);
		}
	}

	private void updateBrachIFSC(int branchId) throws AppException {
		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.update(Schemas.BRANCH);
		queryBuilder.setColumn(Column.IFSC_CODE);
		queryBuilder.where();
		queryBuilder.columnEquals(Column.BRANCH_ID);
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			statement.setString(1, GetterUtil.getIfscCode(branchId));
			statement.setInt(2, branchId);
			int response = statement.executeUpdate();
			if (response != 1) {
				throw new AppException(APIExceptionMessage.IFSC_CODE_UPDATE_FAILED);
			}
		} catch (SQLException e) {
			throw new AppException(e);
		}
	}

	private int createBranchAndGetId(Branch branch) throws AppException {
		ValidatorUtil.validateObject(branch);

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.insertInto(Schemas.BRANCH);
		queryBuilder.insertColumns(
				List.of(Column.ADDRESS, Column.PHONE, Column.EMAIL, Column.CREATED_AT, Column.MODIFIED_BY));
		queryBuilder.end();
		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery(), Statement.RETURN_GENERATED_KEYS)) {
			statement.setString(1, branch.getAddress());
			statement.setLong(2, branch.getPhone());
			statement.setString(3, branch.getEmail());
			statement.setLong(4, branch.getCreatedAt());
			statement.setInt(5, branch.getModifiedBy());

			statement.executeUpdate();
			try (ResultSet result = statement.getGeneratedKeys()) {
				if (result.next()) {
					return result.getInt(1);
				} else {
					throw new AppException(APIExceptionMessage.BRANCH_CREATION_FAILED);
				}
			}
		} catch (SQLException e) {
			throw new AppException(e);
		}
	}

	@Override
	public int createBranch(Branch branch) throws AppException {
		try {
			int branchId = createBranchAndGetId(branch);
			updateBrachIFSC(branchId);
			return branchId;
		} catch (AppException e) {
			throw new AppException(e);
		}

	}

	@Override
	public boolean updateBranchDetails(Branch branch, ModifiableField field, Object value) throws AppException {
		ValidatorUtil.validateObject(value);
		ValidatorUtil.validateObject(field);
		ValidatorUtil.validateObject(branch);
		branch.setModifiedAt(System.currentTimeMillis());

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.update(Schemas.BRANCH);
		queryBuilder.setColumn(Column.valueOf(field.toString()));
		queryBuilder.separator();
		queryBuilder.columnEquals(Column.MODIFIED_BY);
		queryBuilder.separator();
		queryBuilder.columnEquals(Column.MODIFIED_AT);
		queryBuilder.where();
		queryBuilder.columnEquals(Column.BRANCH_ID);
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			statement.setObject(1, value);
			statement.setInt(2, branch.getModifiedBy());
			statement.setLong(2, branch.getModifiedAt());
			statement.setInt(2, branch.getBranchId());

			int response = statement.executeUpdate();
			if (response != 1) {
				return true;
			} else {
				throw new AppException(APIExceptionMessage.UPDATE_FAILED);
			}
		} catch (SQLException e) {
			throw new AppException(e);
		}
	}

	@Override
	public Map<Integer, Branch> getBranchesInBank(int pageNumber) throws AppException {
		ValidatorUtil.validateId(pageNumber);

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.selectColumn(Column.ALL);
		queryBuilder.fromSchema(Schemas.BRANCH);
		queryBuilder.sortField(Column.BRANCH_ID, false);
		queryBuilder.limit(ConstantsUtil.LIST_LIMIT);
		queryBuilder.offset(ConvertorUtil.convertPageToOffset(pageNumber));
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			try (ResultSet branchRS = statement.executeQuery()) {
				Map<Integer, Branch> branch = new LinkedHashMap<Integer, Branch>();
				while (branchRS.next()) {
					branch.put(branchRS.getInt(1), MySQLConversionUtil.convertToBranch(branchRS));
				}
				return branch;
			}
		} catch (SQLException e) {
			throw new AppException(e);
		}
	}

	@Override
	public int getPageCountOfBranches() throws AppException {
		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.selectCount(Schemas.BRANCH);
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			try (ResultSet countRS = statement.executeQuery()) {
				if (countRS.next()) {
					return GetterUtil.getPageCount(countRS.getInt(1));
				} else {
					throw new AppException(APIExceptionMessage.UNKNOWN_ERROR);
				}
			}
		} catch (SQLException e) {
			throw new AppException(e);
		}
	}

	@Override
	public Map<Long, Account> viewAccountsInBank(int pageNumber) throws AppException {

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.selectColumn(Column.ALL);
		queryBuilder.fromSchema(Schemas.ACCOUNTS);
		queryBuilder.sortField(Column.ACCOUNT_NUMBER, true);
		queryBuilder.limit(ConstantsUtil.LIST_LIMIT);
		queryBuilder.offset(ConvertorUtil.convertPageToOffset(pageNumber));
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			try (ResultSet accountRS = statement.executeQuery()) {
				Map<Long, Account> accounts = new LinkedHashMap<Long, Account>();
				while (accountRS.next()) {
					accounts.put(accountRS.getLong(1), MySQLConversionUtil.convertToAccount(accountRS));
				}
				return accounts;
			}
		} catch (SQLException e) {
			throw new AppException(e);
		}
	}

	@Override
	public Map<Integer, EmployeeRecord> getEmployees(int pageNumber) throws AppException {
		Map<Integer, EmployeeRecord> employees = new LinkedHashMap<Integer, EmployeeRecord>();

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.selectColumn(Column.ALL);
		queryBuilder.fromSchema(Schemas.EMPLOYEES);
		queryBuilder.sortField(Column.USER_ID, false);
		queryBuilder.limit(ConstantsUtil.LIST_LIMIT);
		queryBuilder.offset(ConvertorUtil.convertPageToOffset(pageNumber));
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			try (ResultSet result = statement.executeQuery()) {
				while (result.next()) {
					EmployeeRecord employee = MySQLConversionUtil.convertToEmployeeRecord(result);
					MySQLAPIUtil.getAndUpdateUserRecord(employee);
					employees.put(employee.getUserId(), employee);
				}
				return employees;
			}
		} catch (Exception e) {
			throw new AppException();
		}
	}

	@Override
	public int getPageCountOfEmployees() throws AppException {

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.selectCount(Schemas.EMPLOYEES);
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			try (ResultSet result = statement.executeQuery()) {
				while (result.next()) {
					return GetterUtil.getPageCount(result.getInt(1));
				}
			}
			throw new AppException(APIExceptionMessage.UNKNOWN_ERROR);
		} catch (SQLException e) {
			throw new AppException(APIExceptionMessage.DB_COMMUNICATION_FAILED);
		}
	}

	@Override
	public int getPageCountOfAccountsInBank() throws AppException {
		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.selectCount(Schemas.ACCOUNTS);
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			try (ResultSet countRS = statement.executeQuery()) {
				if (countRS.next()) {
					return GetterUtil.getPageCount(countRS.getInt(1));
				} else {
					throw new AppException(APIExceptionMessage.UNKNOWN_ERROR);
				}
			}
		} catch (SQLException e) {
			throw new AppException(e);
		}
	}

	@Override
	public boolean generateApiKey(APIKey apiKey) throws AppException {
		ValidatorUtil.validateObject(apiKey);

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.insertInto(Schemas.API_KEYS);
		queryBuilder.insertColumns(
				List.of(Column.ORG_NAME, Column.API_KEY, Column.CREATED_AT, Column.VALID_UNTIL, Column.MODIFIED_AT));
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery(), Statement.RETURN_GENERATED_KEYS)) {
			statement.setString(1, apiKey.getOrgName());
			statement.setString(2, apiKey.getAPIKey());
			statement.setLong(3, apiKey.getCreatedAt());
			statement.setLong(4, apiKey.getValidUntil());
			statement.setLong(5, apiKey.getModifiedAt());

			statement.executeUpdate();
			try (ResultSet key = statement.getGeneratedKeys()) {
				if (key.next()) {
					apiKey.setAkId(key.getLong(1));
					apiKey.setIsActive(true);
					return true;
				} else {
					throw new AppException(APIExceptionMessage.API_GENERATION_FAILED);
				}
			}
		} catch (SQLException e) {
			throw new AppException(APIExceptionMessage.UNKNOWN_ERROR);
		}
	}

	@Override
	public int getPageCountOfAPIKeys() throws AppException {
		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.selectCount(Schemas.API_KEYS);
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			try (ResultSet countRS = statement.executeQuery()) {
				if (countRS.next()) {
					return GetterUtil.getPageCount(countRS.getInt(1));
				} else {
					throw new AppException(APIExceptionMessage.UNKNOWN_ERROR);
				}
			}
		} catch (SQLException e) {
			throw new AppException(e);
		}
	}

	@Override
	public List<APIKey> getListOfAPIKeys(int pageNumber) throws AppException {
		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.selectColumn(Column.ALL);
		queryBuilder.fromSchema(Schemas.API_KEYS);
		queryBuilder.sortField(Column.AK_ID, true);
		queryBuilder.limit(ConstantsUtil.LIST_LIMIT);
		queryBuilder.offset(ConvertorUtil.convertPageToOffset(pageNumber));
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			try (ResultSet apiKeyRS = statement.executeQuery()) {
				List<APIKey> apiKeys = new ArrayList<APIKey>();
				while (apiKeyRS.next()) {
					apiKeys.add(MySQLConversionUtil.convertToAPIKey(apiKeyRS));
				}
				return apiKeys;
			}
		} catch (SQLException e) {
			throw new AppException(e);
		}
	}

	@Override
	public boolean isDBInitialized() {
		try {
			MySQLQuery query = new MySQLQuery();
			query.selectCount(Schemas.USERS);
			query.end();

			try (ResultSet resultSet = ServerConnection.getServerConnection().prepareCall(query.getQuery())
					.executeQuery()) {
				if (resultSet.next()) {
					return resultSet.getInt(1) > 0;
				}
			} catch (Exception e) {
				LogUtil.logException(e);
			}
		} catch (Exception e) {
			LogUtil.logException(e);
		}
		return false;
	}

}
