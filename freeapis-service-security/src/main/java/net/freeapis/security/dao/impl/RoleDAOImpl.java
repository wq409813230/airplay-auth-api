package net.freeapis.security.dao.impl;

import net.freeapis.core.cache.Redis;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mysql.GenericDAOImpl;
import net.freeapis.security.dao.RoleDAO;
import net.freeapis.security.face.entity.Role;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: RoleDaoImpl.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: RoleDaoImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年07月18日		framework		Initial.
 *
 * </pre>
 */
@Repository(value = "roleDAO")
public class RoleDAOImpl extends GenericDAOImpl<Role> implements RoleDAO {

	private String FIND_USER_SPU_POOLS_SQL = " SELECT SPU_POOLS as spuPools FROM SECURITY_ROLE WHERE ROLE_CODE IN (" +
			" SELECT ROLE_CODE FROM security_user_role WHERE USER_ID = :USER_ID )";

	private String FIND_USER_PRODUCE_RECORD_TYPE_SQL = " SELECT PRODUCE_RECORD_TYPE as produceRecordType FROM SECURITY_ROLE a WHERE EXISTS  (" +
			" SELECT ROLE_CODE FROM security_user_role b WHERE a.ROLE_CODE=b.ROLE_CODE AND USER_ID = :USER_ID )";

	@Override
	public void update(Role role) throws Exception {
		super.update(role);
		Redis.removeSingle(Role.class, role.getAgencyCode(), role.getRoleCode());
	}

	@Override
	public void deleteByRoleCode(String agencyCode, String roleCode) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("AGENCY_CODE", agencyCode);
		params.put("ROLE_CODE", roleCode);
		this.update("DELETE FROM "+ this.tableName() +" WHERE AGENCY_CODE = :AGENCY_CODE AND ROLE_CODE = :ROLE_CODE", params);
		Redis.removeSingle(Role.class, agencyCode, roleCode);
	}

	@Override
	public Role findByCode(String agencyCode, String roleCode) throws Exception {
		Role role = Redis.getSingle(this.getEntityClass(), agencyCode, roleCode);
		if (ValidationUtil.isEmpty(role)) {
			StringBuilder sql = new StringBuilder();
			Map<String, Object> params = new HashMap<String, Object>();
			if (!ValidationUtil.isEmpty(agencyCode)) {
				sql.append(" AND AGENCY_CODE= :AGENCY_CODE ");
				params.put("AGENCY_CODE", agencyCode);
			}
			if (!ValidationUtil.isEmpty(roleCode)) {
				sql.append(" AND ROLE_CODE= :ROLE_CODE ");
				params.put("ROLE_CODE", roleCode);
			}
			role = this.findFirst(sql.toString(), params);
		}
		return role;
	}

	@Override
	public List<Role> findRoles(String agencyCode, String roleCode, String roleName, String lockStatus)
			throws Exception {
		StringBuilder sql = new StringBuilder();
		Map<String, Object> params = new HashMap<String, Object>();
		if (!ValidationUtil.isEmpty(agencyCode)) {
			sql.append(" AND AGENCY_CODE= :AGENCY_CODE ");
			params.put("AGENCY_CODE", agencyCode);
		}
		if (!ValidationUtil.isEmpty(roleCode)) {
			sql.append(" AND ROLE_CODE= :ROLE_CODE ");
			params.put("ROLE_CODE", roleCode);
		}
		if (!ValidationUtil.isEmpty(roleName)) {
			sql.append(" AND ").append(like("ROLE_NAME",":ROLE_NAME"));
			params.put("ROLE_NAME", roleName);
		}
		if (!ValidationUtil.isEmpty(lockStatus)) {
			sql.append(" AND LOCK_STATUS= :LOCK_STATUS ");
			params.put("LOCK_STATUS", lockStatus);
		}

		return this.find(sql.toString(), params, "recDate", "desc");
	}

	@Override
	public List<Role> findByPage(String agencyCode, String roleCode, String roleName, String lockStatus, Page page,
			String orderBy, String order) throws Exception {
		StringBuilder sql = new StringBuilder();
		Map<String, Object> params = new HashMap<String, Object>();
		if (!ValidationUtil.isEmpty(agencyCode)) {
			sql.append(" AND AGENCY_CODE= :AGENCY_CODE ");
			params.put("AGENCY_CODE", agencyCode);
		}
		if (!ValidationUtil.isEmpty(roleCode)) {
			sql.append(" AND ROLE_CODE= :ROLE_CODE ");
			params.put("ROLE_CODE", roleCode);
		}
		if (!ValidationUtil.isEmpty(roleName)) {
			sql.append(" AND ").append(like("ROLE_NAME",":ROLE_NAME"));
			params.put("ROLE_NAME", roleName);
		}
		if (!ValidationUtil.isEmpty(lockStatus)) {
			sql.append(" AND LOCK_STATUS= :LOCK_STATUS ");
			params.put("LOCK_STATUS", lockStatus);
		}
		return this.paginate(sql.toString(), params, page, orderBy, order);
	}

	@Override
	public boolean isRoleNameAvailable(String roleName, Long id) throws Exception {
		StringBuilder sql = new StringBuilder(" AND ROLE_NAME =  :roleName");
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("roleName",roleName);
		if(!ValidationUtil.isEmpty(id)){
			sql.append(" AND SEQUENCE_NBR != :SEQUENCE_NBR ");
			params.put("SEQUENCE_NBR",id);
		}
		Role role = this.findFirst(sql.toString(), params);
        return ValidationUtil.isEmpty(role);
    }

	@Override
	public boolean isRoleCodeAvailable(String roleCode, Long id) throws Exception {
		StringBuilder sql = new StringBuilder();
		Map<String,Object> params = new HashMap<String,Object>();
		sql.append(" AND ROLE_CODE = :ROLE_CODE ");
		params.put("ROLE_CODE",roleCode);

		if(!ValidationUtil.isEmpty(id)){
			sql.append(" AND SEQUENCE_NBR != :SEQUENCE_NBR ");
			params.put("SEQUENCE_NBR",id);
		}
		Role role=this.findFirst(sql.toString(), params);
        return ValidationUtil.isEmpty(role);
    }

	@Override
	public List<Map<String, Object>> findSpuPoolsByUserId(Long userId) throws Exception {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("USER_ID",userId);
		return this.findMaps(FIND_USER_SPU_POOLS_SQL,params);
	}

	@Override
	public List<Map<String, Object>> findProduceRecordTypeByUserId(Long userId) throws Exception {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("USER_ID",userId);
		return this.findMaps(FIND_USER_PRODUCE_RECORD_TYPE_SQL,params);
	}
}
