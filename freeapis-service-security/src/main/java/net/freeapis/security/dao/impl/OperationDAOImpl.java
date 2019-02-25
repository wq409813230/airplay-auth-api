package net.freeapis.security.dao.impl;

import net.freeapis.core.cache.Redis;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mysql.GenericDAOImpl;
import net.freeapis.security.dao.OperationDAO;
import net.freeapis.security.face.constants.SecurityConstants;
import net.freeapis.security.face.entity.Operation;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: SecurityResourceDaoImpl.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: SecurityResourceDaoImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis\wuqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年6月16日		wuqiang		Initial.
 *
 * </pre>
 */
@Repository(value="operationDAO")
public class OperationDAOImpl extends GenericDAOImpl<Operation> implements OperationDAO
{
	@Override
	public void insert(Operation entity) throws Exception {
		super.insert(entity);
		Redis.remove(SecurityConstants.CACHE_KEY_ALL_OPERATIONS);
	}

	@Override
	public void update(Operation entity) throws Exception {
		super.update(entity);
		Redis.remove(SecurityConstants.CACHE_KEY_ALL_OPERATIONS);
	}

	@Override
	public int deleteAllOperations() throws Exception {
		Redis.remove(SecurityConstants.CACHE_KEY_ALL_OPERATIONS);
		StringBuilder sql = new StringBuilder("DELETE FROM ")
				.append(this.tableName()).append(" WHERE RES_TYPE = :RES_TYPE ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("RES_TYPE", SecurityConstants.RES_TYPE_API);
		return this.update(sql.toString(), null);
	}

	@Override
	public void cleanModuleOperation() throws Exception {
		StringBuilder cleanSql = new StringBuilder()
				.append(" DELETE")
				.append(" FROM")
				.append(" SECURITY_MODULE_OPERATION")
				.append("WHERE")
				.append(" SEQUENCE_NBR IN (")
				.append("  SELECT")
				.append("   T.SEQUENCE_NBR")
				.append("  FROM")
				.append("    (SELECT")
				.append("     MO.SEQUENCE_NBR")
				.append("    FROM")
				.append("     SECURITY_MODULE_OPERATION MO")
				.append("    WHERE")
				.append("     NOT EXISTS (")
				.append("      SELECT 1 FROM")
				.append("       SECURITY_OPERATION O")
				.append("      WHERE")
				.append("       MO.FUNC_ID = O.FUNC_ID)")
				.append("   ) T")
				.append(" )");
		this.update(cleanSql.toString(),null);
	}

	@Override
	public void cleanPermission() throws Exception {
		StringBuilder cleanSql = new StringBuilder()
				.append(" DELETE")
				.append(" FROM")
				.append(" SECURITY_PERMISSION")
				.append("WHERE")
				.append(" SEQUENCE_NBR IN (")
				.append("  SELECT")
				.append("   T.SEQUENCE_NBR")
				.append("  FROM")
				.append("    (SELECT")
				.append("     MO.SEQUENCE_NBR")
				.append("    FROM")
				.append("     SECURITY_PERMISSION SP")
				.append("    WHERE")
				.append("     NOT EXISTS (")
				.append("      SELECT 1 FROM")
				.append("       SECURITY_OPERATION O")
				.append("      WHERE")
				.append("       SP.FUNC_ID = O.FUNC_ID)")
				.append("   ) T")
				.append(" )");
		this.update(cleanSql.toString(),null);
	}

	@Override
	public Operation findByFid(String funcId) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("FUNC_ID", funcId);
		return this.findFirst("AND FUNC_ID = :FUNC_ID", params);
	}

	@Override
	public List<Operation> findAllOperations()throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		return this.find(" ", params, null, null);
	}

	@Override
	public Boolean isFuncIdAvailable(String funcId, Long id) throws Exception {
		StringBuilder sql = new StringBuilder(" AND FUNC_ID = :FUNC_ID ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("FUNC_ID", funcId);
		if(!ValidationUtil.isEmpty(id)){
			sql.append(" AND SEQUENCE_NBR!=SEQUENCE_NBR");
			params.put("SEQUENCE_NBR",id);
		}
		return this.findCount(sql.toString(), params).compareTo(0L) <= 0;
	}

	@Override
	public List<Operation> findForPage(String resourceName, Page page, String orderBy, String order) throws Exception {
		StringBuilder sql = new StringBuilder();
		Map<String,Object> params = new HashMap<String,Object>();
		if (!ValidationUtil.isEmpty(resourceName)){
			sql.append(" AND ").append(like("RESOURCE_NAME",":RESOURCE_NAME"));
			params.put("RESOURCE_NAME",resourceName);
		}
		sql.append(" AND REQ_MODE != 'GET' ");
		if (ValidationUtil.isEmpty(orderBy)){
			orderBy = "REC_DATE";
		}
		if (ValidationUtil.isEmpty(order)){
			order = "DESC";
		}

		return this.paginate(sql.toString(),params,page,orderBy,order);
	}
}
