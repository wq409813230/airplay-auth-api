package net.freeapis.security.dao.impl;

import net.freeapis.core.cache.Redis;
import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mysql.GenericDAOImpl;
import net.freeapis.security.dao.ModuleDAO;
import net.freeapis.security.face.constants.SecurityConstants;
import net.freeapis.security.face.entity.Module;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
 *
 * <pre>
 *
 *  freeapis
 *  File: ModuleDAOImpl.java
 *
 *  freeapis, Inc.
 *  Copyright (C): 2015
 *
 *  Description:
 *  TODO
 *
 *  Notes:
 *  $Id: ModuleDAOImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis\wuqiang $
 *
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年6月16日		wuqiang		Initial.
 *
 * </pre>
 */
@Repository(value="moduleDAO")
public class ModuleDAOImpl extends GenericDAOImpl<Module> implements ModuleDAO
{
	@Override
	public Module findByModuleCode(String agencyCode,String moduleCode) throws Exception {
		Module module = Redis.getSingle(Module.class, agencyCode,moduleCode);
		if(ValidationUtil.isEmpty(module)){
			String sqlSufix = " AND AGENCY_CODE = :AGENCY_CODE AND MODULE_CODE = :MODULE_CODE ";
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("AGENCY_CODE", agencyCode);
			params.put("MODULE_CODE", moduleCode);
			module = this.findFirst(sqlSufix, params);
			if(!ValidationUtil.isEmpty(module)){
				Redis.setSingle(module, agencyCode,moduleCode);
			}
		}
		return module;
	}

	@Override
	public List<Module> findByParentCode(String agencyCode,String parentCode, boolean isAgencyTemplate)throws Exception{
		StringBuilder sql = new StringBuilder();
		Map<String, Object> params = new HashMap<String, Object>();
		sql.append(" AND AGENCY_CODE = :AGENCY_CODE AND PARENT_CODE = :PARENT_CODE ");

		if(isAgencyTemplate){
			sql.append(" AND IS_AGENCY_TEMPLATE = :IS_AGENCY_TEMPLATE ");
			params.put("IS_AGENCY_TEMPLATE", CoreConstants.COMMON_Y);
		}

		params.put("AGENCY_CODE", agencyCode);
		params.put("PARENT_CODE", parentCode);
		return this.find(sql.toString(), params, "orderNum", "asc" );
	}

	@Override
	public List<Module> findByAgencyCode(String agencyCode) throws Exception {
		StringBuilder sql = new StringBuilder();
		Map<String, Object> params = new HashMap<String, Object>();
		sql.append(" AND AGENCY_CODE = :AGENCY_CODE ");
		params.put("AGENCY_CODE", agencyCode);
		return this.find(sql.toString(), params, "orderNum", "asc" );
	}

	@Override
	public void deleteByModuleCode(String agencyCode,String moduleCode)throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("AGENCY_CODE",agencyCode);
		params.put("MODULE_CODE",moduleCode);
		this.update("DELETE FROM "+ this.tableName() +" WHERE AGENCY_CODE = :AGENCY_CODE AND MODULE_CODE =:MODULE_CODE",params );
		Redis.removeSingle(Module.class, agencyCode,moduleCode);
	}

	@Override
	public boolean isModuleCodeAvailable(String agencyCode,String moduleCode, Long id)throws Exception{
		StringBuilder sql = new StringBuilder(" AND AGENCY_CODE = :AGENCY_CODE AND MODULE_CODE =:MODULE_CODE");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("AGENCY_CODE",agencyCode);
		params.put("MODULE_CODE", moduleCode);
		if(!ValidationUtil.isEmpty(id)){
			sql.append(" AND SEQUENCE_NBR!=:SEQUENCE_NBR");
			params.put("SEQUENCE_NBR",id);
		}
		return this.findCount(sql.toString(), params).compareTo(0L) <= 0;
	}

	@Override
	public void update(Module module) throws Exception {
		super.update(module);
		Redis.removeSingle(Module.class, module.getAgencyCode(),module.getModuleCode());
	}
}
