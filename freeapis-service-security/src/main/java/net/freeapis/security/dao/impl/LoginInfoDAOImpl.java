package net.freeapis.security.dao.impl;

import com.google.common.collect.Maps;
import net.freeapis.core.cache.Redis;
import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.foundation.enumeration.UserType;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mysql.GenericDAOImpl;
import net.freeapis.security.dao.LoginInfoDAO;
import net.freeapis.security.face.entity.LoginInfo;
import net.freeapis.security.face.enums.IdType;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: LoginInfoDAOImpl.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: LoginInfoDAOImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis\freeapis $
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年8月7日		freeapis		Initial.
 *
 * </pre>
 */
@Repository(value = "loginInfoDAO")
public class LoginInfoDAOImpl extends GenericDAOImpl<LoginInfo> implements LoginInfoDAO {

	@Override
	public void deleteByLoginId(String agencyCode, String loginId) throws Exception {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("AGENCY_CODE", agencyCode);
		parameters.put("LOGIN_ID", loginId);
		this.update("DELETE FROM "+ this.tableName() +" WHERE AGENCY_CODE = :AGENCY_CODE AND LOGIN_ID = :LOGIN_ID",parameters);
		Redis.removeSingle(this.getEntityClass(), agencyCode,loginId);
	}

	@Override
	public void update(LoginInfo loginInfo) throws Exception {
		super.update(loginInfo);
		Redis.removeSingle(this.getEntityClass(), loginInfo.getAgencyCode(),loginInfo.getLoginId());
	}
	
	@Override
	public LoginInfo findLoginInfoForLogin(String agencyCode, String loginId,UserType userType,IdType idType) throws Exception {
		StringBuilder authSql = new StringBuilder("SELECT A.* ")
				.append(" FROM SECURITY_LOGIN_INFO A,SECURITY_PRINCIPAL B ")
				.append(" WHERE ")
				.append(" A.USER_ID = B.USER_ID ")
				.append(" AND A.AGENCY_CODE = B.AGENCY_CODE ")
				.append(" AND A.LOGIN_ID = :loginId ")
				.append(" AND A.REC_STATUS =:recStatus ")
				.append(" AND A.AGENCY_CODE = :agencyCode ")
				.append(" AND A.ID_TYPE= :idType ")
				.append(" AND B.USER_TYPE= :userType ");
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("loginId", loginId);
		parameters.put("recStatus", CoreConstants.COMMON_ACTIVE);
		parameters.put("agencyCode", agencyCode);
		parameters.put("idType", idType.name());
		parameters.put("userType", userType.getValue());
		return findFirst(authSql.toString(), parameters);
	}

	@Override
	public LoginInfo findLoginInfo(String agencyCode,String loginId) throws Exception{
		LoginInfo loginInfo = Redis.getSingle(this.getEntityClass(), agencyCode,loginId);
		if (ValidationUtil.isEmpty(loginInfo)) {
			StringBuilder sql = new StringBuilder(" AND AGENCY_CODE = :AGENCY_CODE AND LOGIN_ID = :LOGIN_ID ");
			Map<String, Object> parameters = new HashMap<String, Object>();
			parameters.put("AGENCY_CODE", agencyCode);
			parameters.put("LOGIN_ID", loginId);
			loginInfo = findFirst(sql.toString(), parameters);
			if (!ValidationUtil.isEmpty(loginInfo)) {
				Redis.setSingle(loginInfo, loginInfo.getAgencyCode(),loginInfo.getLoginId());
			}
		}
		return loginInfo;
	}

	@Override
	public List<LoginInfo> findLoginInfos(Long userId) throws Exception {
		StringBuilder sql = new StringBuilder(" AND USER_ID = :USER_ID ");
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("USER_ID", userId);
		return this.find(sql.toString(), parameters,null,null);
	}

	@Override
	public boolean isLoginIdAvailable(String agencyCode, String loginId) throws Exception {
		StringBuilder sql = new StringBuilder(" AND AGENCY_CODE = :AGENCY_CODE AND LOGIN_ID = :LOGIN_ID ");
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("AGENCY_CODE", agencyCode);
		parameters.put("LOGIN_ID", loginId);
		return this.findCount(sql.toString(), parameters).intValue() <= 0;
	}

	@Override
	public LoginInfo findLoginInfoByUserIdAndIdType(Long userId, String IdType) throws Exception {
		StringBuilder sql = new StringBuilder(" AND USER_ID = :USER_ID AND ID_TYPE = :ID_TYPE ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("USER_ID", userId);
		params.put("ID_TYPE", IdType);
		return this.findFirst(sql.toString(),params);
	}

	@Override
	public List<String> findByUserIds(List<String> userIds, String IdType) throws Exception {
		StringBuilder sql = new StringBuilder(" SELECT LOGIN_ID loginId FROM security_login_info WHERE 1=1 ");
		sql.append(" AND ID_TYPE = '"+IdType+"' AND USER_ID IN(");
		for (String userId : userIds){
			sql.append(userId + ",");
		}
		sql.deleteCharAt(sql.length()-1);
		sql.append(")");
		return this.findObjects(sql.toString(),null);
	}
}

/*
 * $Log: av-env.bat,v $
 */