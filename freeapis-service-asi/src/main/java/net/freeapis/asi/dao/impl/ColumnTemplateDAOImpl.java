package net.freeapis.asi.dao.impl;

import net.freeapis.asi.dao.ColumnTemplateDAO;
import net.freeapis.asi.face.entity.ColumnTemplate;
import net.freeapis.core.cache.Redis;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mysql.GenericDAOImpl;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: ColumnTemplateDaoImpl.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: ColumnTemplateDaoImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年08月18日		framework		Initial.
 *
 * </pre>
 */
@Repository(value="columnTemplateDAO")
public class ColumnTemplateDAOImpl extends GenericDAOImpl<ColumnTemplate> implements ColumnTemplateDAO
{

	@Override
	public void insertWithCache(ColumnTemplate columnTemplate) throws Exception {
		this.insert(columnTemplate);
		Redis.setSingle(columnTemplate,columnTemplate.getAgencyCode(), columnTemplate.getColumnCode());
	}

	@Override
	public void deleteWithCache(String agencyCode, String columnCode) throws Exception {
		ColumnTemplate currentColumn = this.getWithCache(agencyCode, columnCode);
		if (!ValidationUtil.isEmpty(currentColumn)) {
			StringBuilder sql = new StringBuilder(" DELETE FROM "+ this.tableName() +" WHERE 1=1 ")
					.append(" AND AGENCY_CODE = :AGENCY_CODE AND COLUMN_CODE = :COLUMN_CODE ");
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("AGENCY_CODE", agencyCode);
			params.put("COLUMN_CODE", columnCode);
			this.update(sql.toString(), params);
			Redis.removeSingle(this.getEntityClass(), agencyCode, columnCode);
		}
	}

	@Override
	public void updateWithCache(ColumnTemplate columnTemplate) throws Exception {
		this.update(columnTemplate);
		Redis.setSingle(columnTemplate, columnTemplate.getAgencyCode(), columnTemplate.getColumnCode());
	}

	@Override
	public ColumnTemplate getWithCache(String agencyCode, String columnCode) throws Exception {
		ColumnTemplate result = Redis.getSingle(this.getEntityClass(), agencyCode, columnCode);
		if (ValidationUtil.isEmpty(result)) {
			StringBuilder sql = new StringBuilder(" AND AGENCY_CODE = :AGENCY_CODE AND COLUMN_CODE = :COLUMN_CODE ");
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("AGENCY_CODE", agencyCode);
			params.put("COLUMN_CODE", columnCode);
			result = this.findFirst(sql.toString(), params);
			if (!ValidationUtil.isEmpty(result)) {
				Redis.setSingle(result, result.getAgencyCode(), result.getColumnCode());
			}
		}
		return result;
	}

	@Override
	public List<ColumnTemplate> findColumnTemplateByPage(String agencyCode, String columnCode, String columnName,
			Page page,String orderBy,String order) throws Exception {
		StringBuilder sql = new StringBuilder();
		Map<String, Object> params = new HashMap<String, Object>();
		if (!ValidationUtil.isEmpty(agencyCode)) {
			sql.append(" AND AGENCY_CODE = :AGENCY_CODE ");
			params.put("AGENCY_CODE", agencyCode);
		}
		if (!ValidationUtil.isEmpty(columnCode)) {
			sql.append(" AND COLUMN_CODE = :COLUMN_CODE ");
			params.put("COLUMN_CODE", columnCode);
		}
		if (!ValidationUtil.isEmpty(columnName)) {
			sql.append(" AND ").append(like("COLUMN_NAME",":COLUMN_NAME"));
			params.put("COLUMN_NAME", columnName);
		}
		return this.paginate(sql.toString(), params, page, orderBy, order);
	}

}
