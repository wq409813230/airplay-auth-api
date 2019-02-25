package net.freeapis.security.dao.impl;

import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mysql.GenericDAOImpl;
import net.freeapis.security.dao.ModuleOperationDAO;
import net.freeapis.security.face.entity.ModuleOperation;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: SecurityModuleResourceDaoImpl.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: SecurityModuleResourceDaoImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis\wuqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年6月16日		wuqiang		Initial.
 *
 * </pre>
 */
@Repository(value="moduleOperationDAO")
public class ModuleOperationDAOImpl extends GenericDAOImpl<ModuleOperation> implements ModuleOperationDAO
{
	@Override
	public List<ModuleOperation> findByModuleCode(String agencyCode,String moduleCode) throws Exception {
		String sqlSufix = " AND AGENCY_CODE=:AGENCY_CODE AND MODULE_CODE = :MODULE_CODE ";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("AGENCY_CODE", agencyCode);
		params.put("MODULE_CODE", moduleCode);
		return this.find(sqlSufix, params, null, null);
	}

	@Override
	public void deleteByModule(String agencyCode, String moduleCode) throws Exception {
		String sql = " DELETE FROM security_module_operation WHERE " +
				" AGENCY_CODE=:AGENCY_CODE AND MODULE_CODE = :MODULE_CODE ";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("AGENCY_CODE", agencyCode);
		params.put("MODULE_CODE", moduleCode);
		this.update(sql, params);
	}

	@Override
	public List<ModuleOperation> findByAgencyCode(String agencyCode) throws Exception {
		String sqlSufix = " AND AGENCY_CODE=:AGENCY_CODE";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("AGENCY_CODE", agencyCode);
		return this.find(sqlSufix, params, null, null);
	}

	@Override
	public boolean isOperationButtonCodeAvailable(String agencyCode, String moduleCode, String buttonCode, Long id) throws Exception {
		StringBuilder sql = new StringBuilder(" AND AGENCY_CODE = :AGENCY_CODE " +
				" AND MODULE_CODE=:MODULE_CODE " +
				" AND BUTTON_CODE=:BUTTON_CODE ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("AGENCY_CODE", agencyCode);
		params.put("MODULE_CODE", moduleCode);
		params.put("BUTTON_CODE", buttonCode);
		if(!ValidationUtil.isEmpty(id)){
			sql.append(" AND SEQUENCE_NBR!=SEQUENCE_NBR");
			params.put("SEQUENCE_NBR",id);
		}
		return this.findCount(sql.toString(), params).compareTo(0L) <= 0;
	}

	@Override
	public List<ModuleOperation> findByPage(String agencyCode, String moduleCode, String buttonName, Page page, String order, String orderBy) throws Exception {
		StringBuilder sql = new StringBuilder();
		Map<String, Object> params = new HashMap<String, Object>();
		if(!ValidationUtil.isEmpty(agencyCode)){
			sql.append(" AND AGENCY_CODE=:AGENCY_CODE ");
			params.put("AGENCY_CODE", agencyCode);
		}
		if(!ValidationUtil.isEmpty(moduleCode)){
			sql.append(" AND MODULE_CODE = :MODULE_CODE ");
			params.put("MODULE_CODE", moduleCode);
		}
		if(!ValidationUtil.isEmpty(buttonName)){
			sql.append(" AND ").append(like("BUTTON_NAME",":BUTTON_NAME"));
			params.put("BUTTON_NAME", buttonName);
		}
		if(ValidationUtil.isEmpty(order)){
			order = "desc";
		}
		if(ValidationUtil.isEmpty(orderBy)){
			orderBy = "sequenceNbr";
		}

		return this.paginate(sql.toString(),params,page,orderBy,order);
	}
}
