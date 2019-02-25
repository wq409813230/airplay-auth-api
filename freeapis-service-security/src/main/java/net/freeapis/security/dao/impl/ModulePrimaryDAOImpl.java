package net.freeapis.security.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import net.freeapis.core.mysql.GenericDAOImpl;
import net.freeapis.security.dao.ModulePrimaryDAO;
import net.freeapis.security.face.entity.ModulePrimary;
/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: SecurityModuleRoleDaoImpl.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: SecurityModuleRoleDaoImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis\wuqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年6月16日		wuqiang		Initial.
 *
 * </pre>
 */
@Repository(value="moduleRoleDAO")
public class ModulePrimaryDAOImpl extends GenericDAOImpl<ModulePrimary> implements ModulePrimaryDAO
{

	@Override
	public List<ModulePrimary> findByPrimaryInfo(String agencyCode, String primaryType, String primaryCode) throws Exception {
		String sqlSufix = " AND AGENCY_CODE = :AGENCY_CODE AND PRIMARY_TYPE = :PRIMARY_TYPE AND PRIMARY_CODE = :PRIMARY_CODE ";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("AGENCY_CODE", agencyCode);
		params.put("PRIMARY_TYPE", primaryType);
		params.put("PRIMARY_CODE", primaryCode);
		return this.find(sqlSufix, params, null, null);
	}

	@Override
	public int deleteByPrimaryInfo(String agencyCode, String primaryType, String primaryCode) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("AGENCY_CODE", agencyCode);
		params.put("PRIMARY_TYPE", primaryType);
		params.put("PRIMARY_CODE", primaryCode);
		return this.update("DELETE FROM "+ this.tableName() +" WHERE AGENCY_CODE = :AGENCY_CODE AND PRIMARY_TYPE = :PRIMARY_TYPE AND PRIMARY_CODE = :PRIMARY_CODE ", params);
	}

}
