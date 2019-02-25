package net.freeapis.security.dao.impl;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import net.freeapis.core.cache.Redis;
import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.foundation.enumeration.UserType;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mysql.GenericDAOImpl;
import net.freeapis.security.dao.PrincipalDAO;
import net.freeapis.security.face.entity.Principal;
import org.springframework.stereotype.Repository;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
 *
 * <pre>
 *
 *  freeapis
 *  File: PrincipalDAOImpl.java
 *
 *  freeapis, Inc.
 *  Copyright (C): 2015
 *
 *  Description:
 *  TODO
 *
 *  Notes:
 *  $Id: PrincipalDAOImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $
 *
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年07月18日		framework		Initial.
 *
 * </pre>
 */
@Repository(value="principalDAO")
public class PrincipalDAOImpl extends GenericDAOImpl<Principal> implements PrincipalDAO
{
	@Override
	public void deleteByUserId(Long userId) throws Exception {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("USER_ID",userId);
		this.update("DELETE FROM "+ this.tableName() +" WHERE USER_ID = :USER_ID",params);
		Redis.removeSingle(this.getEntityClass(),userId.toString());
	}

	@Override
	public void update(Principal principal) throws Exception {
		super.update(principal);
		Redis.removeSingle(this.getEntityClass(), principal.getUserId().toString());
	}

	@Override
	public Principal findByUserId(Long userId) throws Exception {
		Principal principal = Redis.getSingle(this.getEntityClass(), userId.toString());
		if(ValidationUtil.isEmpty(principal)){
			StringBuilder sql = new StringBuilder(" AND USER_ID = :USER_ID ");
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("USER_ID",userId);
			principal = this.findFirst(sql.toString(), params);
			if(!ValidationUtil.isEmpty(principal)){
				Redis.setSingle(principal,principal.getUserId().toString());
			}
		}
		return principal;
	}

	@Override
	public void cleanTestData(Long userId,String cleanType) throws Exception {
		/*List<String> tableNames = new ArrayList<String>();
		List<String> cleanSqls = new ArrayList<String>();
		for(String tableName : tableNames){
			cleanSqls.add(" DELETE FROM " + tableName + " WHERE USER_ID = :USER_ID ");
		}
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("USER_ID",userId);
		for(String sql:cleanSqls){
			this.update(sql,params);
		}*/
	}

    @Override
    public List<Principal> findBrieflyEmployee(String agencyCode, Integer userType) throws Exception {
		if (ValidationUtil.isEmpty(agencyCode) || ValidationUtil.isEmpty(userType)){
			return Lists.newArrayList();
		}
		StringBuilder sql = new StringBuilder();
		Map<String, Object> params = new HashMap<String, Object>();
		sql.append(" AND AGENCY_CODE = :AGENCY_CODE ");
		sql.append(" AND USER_TYPE = :USER_TYPE ");
		sql.append(" AND LOCK_STATUS = :LOCK_STATUS ");
		sql.append(" AND REC_STATUS = :REC_STATUS ");
		params.put("AGENCY_CODE", agencyCode);
		params.put("USER_TYPE", userType);
		params.put("LOCK_STATUS", CoreConstants.COMMON_N);
		params.put("REC_STATUS",CoreConstants.COMMON_ACTIVE);
		return this.find(sql.toString(), params, null, null);
    }

	@Override
	public List<Map<String, Object>> findUserNameByUserIds(List<Long> userIds) throws Exception {
		if (ValidationUtil.isEmpty(userIds)){
			return Lists.newArrayList();
		}
		StringBuilder sql = new StringBuilder(" SELECT * FROM security_principal WHERE USER_ID IN ( ");
		Map<String,Object> params = Maps.newHashMap();
		for (int i = 0; i < userIds.size(); i++) {
			sql.append(" :USER_ID" + i + ",");
			params.put("USER_ID" + i, userIds.get(i));
		}
		sql.deleteCharAt(sql.length() - 1);
		sql.append(" )");
		return this.findMaps(sql.toString(), params);
	}

	@Override
	public List<Map<String,Object>> findBrieflyEmployeeByRoleCode(String roleCode,String agencyCode, Integer userType) throws Exception {

		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT a.USER_ID userId,a.USER_NAME userName FROM security_principal a ");
		sql.append(" INNER JOIN security_user_role b on a.USER_ID=b.USER_ID ");
		sql.append(" WHERE 1=1 ");
		sql.append(" AND b.ROLE_CODE=:ROLE_CODE ");
		sql.append(" AND a.AGENCY_CODE = :AGENCY_CODE ");
		sql.append(" AND a.USER_TYPE = :USER_TYPE ");
		sql.append(" GROUP BY a.USER_ID ");

		Map<String,Object> params= new HashMap<>();
		params.put("ROLE_CODE",roleCode);
		params.put("AGENCY_CODE", agencyCode);
		params.put("USER_TYPE", userType);
		return this.findMaps(sql.toString(), params);
	}

	@Override
	public Principal findByMobile(String mobile) throws Exception {
		StringBuilder sql = new StringBuilder(" AND MOBILE = :MOBILE ");
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("MOBILE",mobile);
		return this.findFirst(sql.toString(), params);
	}
}
