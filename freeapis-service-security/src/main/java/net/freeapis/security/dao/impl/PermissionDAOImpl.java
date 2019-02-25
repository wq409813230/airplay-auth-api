package net.freeapis.security.dao.impl;

import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mysql.GenericDAOImpl;
import net.freeapis.security.dao.PermissionDAO;
import net.freeapis.security.face.entity.Permission;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: SecurityRolePrivilegeDaoImpl.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: SecurityRolePrivilegeDaoImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis\wuqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年6月16日		wuqiang		Initial.
 *
 * </pre>
 */
@Repository(value="permissionDAO")
public class PermissionDAOImpl extends GenericDAOImpl<Permission> implements PermissionDAO
{

	@Override
	public List<Permission> findByPrimaryInfo(String agencyCode,String moduleCode,String primaryType,String primaryCode) throws Exception{
		StringBuilder sql = new StringBuilder(" AND AGENCY_CODE = :AGENCY_CODE AND PRIMARY_TYPE = :PRIMARY_TYPE AND PRIMARY_CODE = :PRIMARY_CODE ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("AGENCY_CODE", agencyCode);
		params.put("PRIMARY_TYPE", primaryType);
		params.put("PRIMARY_CODE", primaryCode);
		if(!ValidationUtil.isEmpty(moduleCode)){
			sql.append(" AND MODULE_CODE = :MODULE_CODE");
			params.put("MODULE_CODE", moduleCode);
		}
		return this.find(sql.toString(), params, null, null);
	}

	@Override
	public int deleteByPrimaryInfo(String agencyCode, String primaryType, String primaryCode) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("AGENCY_CODE", agencyCode);
		params.put("PRIMARY_TYPE", primaryType);
		params.put("PRIMARY_CODE", primaryCode);
		return this.update("DELETE FROM "+ this.tableName() +" WHERE AGENCY_CODE = :AGENCY_CODE AND PRIMARY_TYPE = :PRIMARY_TYPE AND PRIMARY_CODE = :PRIMARY_CODE ", params);
	}

	@Override
	public List<String> findPrimaryFuncIds(String agencyCode,String primaryType, String primaryCode) throws Exception {
		String sql = "SELECT DISTINCT FUNC_ID FROM SECURITY_MODULE_OPERATION a " +
				" INNER JOIN SECURITY_PERMISSION b " +
				" ON a.MODULE_CODE=b.MODULE_CODE " +
				" AND a.AGENCY_CODE=b.AGENCY_CODE " +
				" AND a.BUTTON_CODE=b.BUTTON_CODE " +
				" AND b.AGENCY_CODE=:AGENCY_CODE " +
				" AND b.PRIMARY_TYPE=:PRIMARY_TYPE " +
				" AND b.PRIMARY_CODE=:PRIMARY_CODE ";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("AGENCY_CODE", agencyCode);
		params.put("PRIMARY_TYPE", primaryType);
		params.put("PRIMARY_CODE", primaryCode);
		return this.findObjects(sql,params);
	}
}
