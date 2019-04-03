package net.freeapis.security.dao.impl;

import com.google.common.collect.Maps;
import net.freeapis.core.cache.Redis;
import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mysql.GenericDAOImpl;
import net.freeapis.security.dao.EmployeeDAO;
import net.freeapis.security.face.entity.Employee;
import net.freeapis.security.face.entity.Principal;
import net.freeapis.security.face.entity.Role;
import net.freeapis.security.face.entity.UserRole;
import org.springframework.stereotype.Repository;

import javax.persistence.Table;
import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <pre>
 *
 *  freeapis
 *  File: EmployeeDAOImpl.java
 *
 *  freeapis, Inc.
 *  Copyright (C): 2015
 *
 *  Description:
 *  TODO
 *
 *  Notes:
 *  $Id: EmployeeDAOImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis $
 *
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016-09-09 15:33:42		freeapis		Initial.
 *
 * </pre>
 */
@Repository(value = "employeeDAO")
public class EmployeeDAOImpl extends GenericDAOImpl<Employee> implements EmployeeDAO {
    @Override
    public void update(Employee employee) throws Exception {
        super.update(employee);
        Redis.removeSingle(this.getEntityClass(), employee.getUserId().toString());
    }

    @Override
    public boolean isEmployeeCodeAvailable(String agencyCode, String employeeCode) throws Exception {
        StringBuilder sql = new StringBuilder(" SELECT COUNT(1) FROM " +
                this.tableName() + " a INNER JOIN " +
                Principal.class.getAnnotation(Table.class).name() + " b " +
                "ON a.USER_ID = b.USER_ID  WHERE a.EMPLOYEE_CODE=:EMPLOYEE_CODE AND a.REC_STATUS = 'A'" +
                "AND b.AGENCY_CODE = :AGENCY_CODE ");
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("EMPLOYEE_CODE", employeeCode);
        params.put("AGENCY_CODE", agencyCode);
        return this.findCount(sql.toString(), params) <= 0;
    }

    @Override
    public Employee findByUserId(Long userId) throws Exception {
        Employee employee = Redis.getSingle(this.getEntityClass(), userId.toString());
        if (ValidationUtil.isEmpty(employee)) {
            StringBuilder sql = new StringBuilder(" AND USER_ID = :USER_ID AND REC_STATUS = 'A'");
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("USER_ID", userId);
            employee = this.findFirst(sql.toString(), params);
            if (!ValidationUtil.isEmpty(employee)) {
                Redis.setSingle(employee, employee.getUserId().toString());
            }
        }
        return employee;
    }

	@Override
	public List<Map<String, Object>> findEmployeeDepartmentByUserIds(List<Long> userIds) throws Exception {
		StringBuffer sql = new StringBuffer(findDepartmentSql() + " WHERE USER_ID IN (") ;
		Map<String, Object> params = Maps.newHashMap();
		for (int i = 0; i < userIds.size(); i++) {
			sql.append(" :USER_ID" + i + ",");
			params.put("USER_ID" + i, userIds.get(i));
		}
		sql.deleteCharAt(sql.length() - 1);
		sql.append(" )");
		return this.findMaps(sql.toString(), params);
	}

	private String findDepartmentSql(){
		String findSql = "SELECT" +
				" EE.SEQUENCE_NBR,"+
				" EE.DEPARTMENT_CODE,"+
				" AD.DEPARTMENT_NAME,"+
				" EE.USER_ID,"+
				" EE.EMPLOYEE_CODE"+
				" FROM AGENCY_EMPLOYEE EE LEFT JOIN AGENCY_DEPARTMENT AD ON EE.`DEPARTMENT_CODE` = AD.`DEPARTMENT_CODE`";
		return findSql;
	}

	@Override
	public List<String> findEmployeeMobile(String employeeCode) throws Exception {
		String findSql = "SELECT SP.MOBILE FROM SECURITY_PRINCIPAL SP WHERE 1=1 " +
				" AND SP.USER_ID = (SELECT AE.USER_ID FROM AGENCY_EMPLOYEE AE WHERE AE.EMPLOYEE_CODE = :EMPLOYEE_CODE AND AE.REC_STATUS = 'A' )";
		Map<String,Object> params = new HashMap<String,Object>();
		if (!ValidationUtil.isEmpty(employeeCode)){
			params.put("EMPLOYEE_CODE",employeeCode);
		}
		return this.findObjects(findSql.toString(),params);
	}

	@Override
	public Long findEmployeeCode(String employeeCode) throws Exception {
		String findSql = " SELECT " +
				" AE.USER_ID " +
				" FROM " +
				" AGENCY_EMPLOYEE AE " +
				" WHERE " +
				" AE.EMPLOYEE_CODE = :EMPLOYEE_CODE " +
				" AND AE.REC_STATUS = 'A' " +
				" AND EXISTS ( " +
				" SELECT " +
				" 1 " +
				" FROM " +
				" SECURITY_PRINCIPAL SP " +
				" WHERE " +
				" AE.USER_ID = SP.USER_ID " +
				" AND SP.LOCK_STATUS = 'N' " +
				" AND SP.REC_STATUS = 'A' " +
				")";
		Map<String,Object> params = new HashMap<String,Object>();
		if (!ValidationUtil.isEmpty(employeeCode)){
			params.put("EMPLOYEE_CODE",employeeCode);
		}
		BigInteger maxSeq = this.findObject(findSql,params);
		if(ValidationUtil.isEmpty(maxSeq)){
			return 0L;
		}
		return maxSeq.longValue();
	}

	@Override
	public List<Map<String,Object>> findByPage(String agencyCode, String departmentCode, String userName, String employeeCode,Page page,String orderBy, String order) throws Exception {
		 String findSql = " SELECT " +
				" EE.SEQUENCE_NBR AS sequenceNBR, " +
				" EE.DEPARTMENT_CODE AS departmentCode, " +
				" AD.DEPARTMENT_NAME AS departmentName,"+
				" EE.USER_ID AS userId, " +
				" EE.EMPLOYEE_CODE AS employeeCode, " +
				" EE.NEED_CHANGE_PASS AS needChangePass, " +
				" EE.REC_DATE AS recDate, " +
				" EE.REC_USER_ID AS recUserId, " +
				" EE.REC_STATUS AS recStatus, " +
				" SP.AVATAR AS avatar, " +
				" SP.USER_NAME AS userName, " +
				" SP.GENDER AS gender, " +
				" SP.MOBILE AS mobile, " +
				" SP.LOCK_STATUS AS lockStatus, " +
				" SP.LOCK_DATE AS lockDate, " +
				" SP.LOCK_USER_ID AS lockUserId, " +
				" ROLE.roleCodes, " +
				" ROLE.roleNames, " +
				" ( " +
				 "  CASE " +
				 "  WHEN cc.user_id = EE.USER_ID THEN " +
				 "   'Y' " +
				 "  ELSE " +
				 "   'N' " +
				 "  END " +
				 " ) as isBind " +
				" FROM "+this.tableName()+" EE " +
				 "INNER JOIN "+
				tableName(Principal.class) +" SP " +
				" ON EE.USER_ID = SP.USER_ID AND EE.REC_STATUS = 'A' " +
				" LEFT JOIN AGENCY_DEPARTMENT AD ON AD.DEPARTMENT_CODE = EE.DEPARTMENT_CODE " +
				" LEFT JOIN " +
				"( SELECT UR.USER_ID,GROUP_CONCAT(UR.ROLE_CODE) roleCodes,GROUP_CONCAT(R.ROLE_NAME) roleNames " +
				" FROM " +
				 tableName(UserRole.class) +" UR INNER JOIN " +
				 tableName(Role.class) +" R " +
				 " ON UR.ROLE_CODE = R.ROLE_CODE " +
				 " AND UR.AGENCY_CODE = R.AGENCY_CODE " +
				 " AND UR.AGENCY_CODE = :AGENCY_CODE " +
				 " GROUP BY UR.USER_ID " +
				 ") ROLE "+
				" ON EE.USER_ID = ROLE.USER_ID " +
				 " left JOIN ( " +
				 " SELECT " +
				 "  * " +
				 " FROM " +
				 "  security_login_info  " +
				 " WHERE " +
				 " ID_TYPE = 'dingTalk' " +
				 ") cc on ee.user_id = cc.user_id " +
				 " WHERE 1=1 AND SP.USER_ID != :SUPER_USER_ID ";

		StringBuilder sql = new StringBuilder(findSql);
		Map<String, Object> params = new HashMap<String, Object>();
		sql.append(" AND SP.AGENCY_CODE = :AGENCY_CODE ");
		params.put("AGENCY_CODE", agencyCode);

		params.put("SUPER_USER_ID", CoreConstants.SUPER_USER_ID);
		if(!ValidationUtil.isEmpty(departmentCode)){
			sql.append(" AND EE.DEPARTMENT_CODE = :DEPARTMENT_CODE ");
			params.put("DEPARTMENT_CODE", departmentCode);
		}
		if(!ValidationUtil.isEmpty(userName)){
			sql.append(" AND ").append(like("SP.USER_NAME",":USER_NAME"));
			params.put("USER_NAME", userName);
		}
		if(!ValidationUtil.isEmpty(employeeCode)){
			sql.append(" AND EE.EMPLOYEE_CODE = :EMPLOYEE_CODE ");
			params.put("EMPLOYEE_CODE", employeeCode);
		}
		if(ValidationUtil.isEmpty(orderBy)){
			orderBy = "recDate";
		}
		if(ValidationUtil.isEmpty(order)){
			order = "asc";
		}
		sql.append(" order By "+orderBy +" "+order);
		return this.findMapsByPage(sql.toString(), params, page);
	}
	
	@Override
	public List<Employee> getEmployeesByRoleCode(String roleCode) throws Exception {
		StringBuilder sql = new StringBuilder();
		Map<String, Object> params = new HashMap<String, Object>();
		sql.append(" AND Z.LOCK_STATUS = 'N' ");
		if(!ValidationUtil.isEmpty(roleCode)){
			sql.append(" AND EXISTS(SELECT (1) FROM "+ UserRole.class.getAnnotation(Table.class).name()+" S WHERE Z.USER_ID = S.USER_ID AND S.ROLE_CODE = :ROLE_CODE ) ");
			params.put("ROLE_CODE", roleCode);
		}
		return this.find(sql.toString(), params, null, null);
	}

	@Override
	public List<Long> findUserIdsByDepartmentCode(String agencyCode, String departmentCode) throws Exception {
		StringBuilder sql = new StringBuilder("SELECT USER_ID userId FROM agency_employee WHERE 1=1 AND AGENCY_CODE = :AGENCY_CODE AND DEPARTMENT_CODE = :DEPARTMENT_CODE");
		Map<String,Object> params = Maps.newHashMap();
		params.put("AGENCY_CODE",agencyCode);
		params.put("DEPARTMENT_CODE",departmentCode);
		return this.findObjects(sql.toString(),params);
	}

    @Override
    public List<Map<String, Object>> findEmployeesByDepartmentCode(String agencyCode, String departmentCode, String localStatus) throws Exception {
    	StringBuilder sql = new StringBuilder("SELECT e.SEQUENCE_NBR AS sequenceNBR," +
				" e.DEPARTMENT_CODE AS departmentCode," +
				" e.USER_ID AS userId," +
				" e.EMPLOYEE_CODE AS employeeCode," +
				" p.USER_NAME AS userName," +
				" p.REAL_NAME AS realName," +
				" p.GENDER AS gender," +
				" p.BIRTH_DATE AS birthDate," +
				" p.AVATAR AS avatar," +
				" p.MOBILE AS mobile" +
				" FROM " + tableName() + " e INNER JOIN " + tableName(Principal.class) + " p " +
				" ON e.USER_ID = p.USER_ID" +
				" WHERE 1 = 1 AND e.AGENCY_CODE = :AGENCY_CODE AND e.DEPARTMENT_CODE = :DEPARTMENT_CODE ");
		Map<String,Object> params = Maps.newHashMap();
		params.put("AGENCY_CODE",agencyCode);
		params.put("DEPARTMENT_CODE",departmentCode);
		if(!ValidationUtil.isEmpty(localStatus)){
			sql.append(" AND p.LOCK_STATUS = :LOCK_STATUS ");
			params.put("LOCK_STATUS", localStatus);
		}
    	return this.findMaps(sql.toString(), params);
    }

	@Override
	public void deleteByUserId(Long userId) throws Exception {
		Employee currentEmployee = this.findByUserId(userId);
		if(!ValidationUtil.isEmpty(currentEmployee)){
			this.delete(currentEmployee.getSequenceNBR());
			Redis.removeSingle(this.getEntityClass(), currentEmployee.getUserId().toString());
		}
	}
}
