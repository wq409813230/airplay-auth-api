package net.freeapis.asi.dao.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import net.freeapis.asi.dao.ASIBizDAO;
import net.freeapis.asi.face.entity.ASIBiz;
import net.freeapis.core.cache.Redis;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mysql.GenericDAOImpl;
/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: GroupDaoImpl.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: GroupDaoImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年08月18日		framework		Initial.
 *
 * </pre>
 */
@Repository(value="asiBizDAO")
public class ASIBizDAOImpl extends GenericDAOImpl<ASIBiz> implements ASIBizDAO
{

	@Override
	public void insertWithCache(ASIBiz asiBiz) throws Exception {
		this.insert(asiBiz);
		Redis.removeSingle(this.getEntityClass(), asiBiz.getAgencyCode(),asiBiz.getEntityType());
	}

	@Override
	public void deleteWithCache(String agencyCode, String entityType) throws Exception {
		
	}

	@Override
	public void updateWithCache(ASIBiz asiBiz) throws Exception {
		this.update(asiBiz);
		Redis.removeSingle(this.getEntityClass(), asiBiz.getAgencyCode(),asiBiz.getEntityType());
	}

	@Override
	public ASIBiz findASIBiz(String agencyCode,String groupCode,String entityType) throws Exception {
		ASIBiz result = Redis.getSingle(this.getEntityClass(), agencyCode,entityType);
		if(ValidationUtil.isEmpty(result)){
			StringBuilder sql = new StringBuilder(" AND AGENCY_CODE = :AGENCY_CODE AND ENTITY_TYPE = :ENTITY_TYPE ");
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("AGENCY_CODE", agencyCode);
			params.put("ENTITY_TYPE", entityType);
			result = this.findFirst(sql.toString(), params);
			if(!ValidationUtil.isEmpty(result)){
				Redis.setSingle(result, result.getAgencyCode(),result.getEntityType());
			}
		}
		return result;
	}
	
}
